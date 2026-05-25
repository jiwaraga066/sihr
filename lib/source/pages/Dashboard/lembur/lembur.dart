part of '../../index.dart';

class LemburScreen extends StatefulWidget {
  const LemburScreen({super.key});

  @override
  State<LemburScreen> createState() => _LemburScreenState();
}

class _LemburScreenState extends State<LemburScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetLemburCubit>(context).getLembur(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Lembur", style: TextStyle(fontFamily: 'JakartaSansMedium')),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, createLemburScreen);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: BlocBuilder<GetLemburCubit, GetLemburState>(
        builder: (context, state) {
          if (state is GetLemburLoading) {
            return Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12),
              child: Column(
                children: [SizedBox(height: 120, child: Skeleton.skeleton1())],
              ),
            );
          }
          if (state is GetLemburFailed) {
            var data = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 403) {
              return const Center(child: Text("This user does not have access."));
            } else if (statusCode == 404) {
              return const Center(child: Text("Not Found"));
            } else {
              return Center(child: Text(data['message'].toString()));
            }
          }
          if (state is GetLemburLoaded == false) {
            return Container();
          }
          var data = (state as GetLemburLoaded).model;
          var idPegawai = (state).idPegawai;
          List datafilter = data!.data!.where((e) => e.idPegawai == idPegawai).toList();
          if (datafilter.isEmpty) {
            return const Center(child: Text("Data Kosong"));
          }
          return Container(
            padding: const EdgeInsets.all(12),
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                BlocProvider.of<GetLemburCubit>(context).getLembur(context);
              },
              child: ListView.builder(
                itemCount: datafilter.length,
                itemBuilder: (context, index) {
                  var a = datafilter[index];
                  if (a.status == 0 || a.status == 1 || a.status == 2 || a.status == 3) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(color: hijauDark, borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        margin: const EdgeInsets.only(left: 12),
                        padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                        decoration: const BoxDecoration(
                          color: whiteCustom2,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(flex: 3, child: AutoSizeText("", style: TextStyle(fontFamily: 'MontserratSemiBold'))),
                                if (a.status == 0)
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        width: 120,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(color: amber, borderRadius: BorderRadius.circular(8), boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(1, 2),
                                          ),
                                        ]),
                                        child: const Text("Pending",
                                            textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                  ),
                                if (a.status == 1)
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(color: Colors.green[600], borderRadius: BorderRadius.circular(8), boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(1, 2),
                                          ),
                                        ]),
                                        child: const Text("ACC KEPALA",
                                            textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                  ),
                                if (a.status == 2)
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(color: merah, borderRadius: BorderRadius.circular(8), boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(1, 2),
                                          ),
                                        ]),
                                        child: const Text("Rejected",
                                            textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                  ),
                                if (a.status == 3)
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8), boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(1, 2),
                                          ),
                                        ]),
                                        child: const Text("ACC HRD",
                                            textAlign: TextAlign.center, style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Table(
                              border: TableBorder.all(style: BorderStyle.none),
                              columnWidths: const <int, TableColumnWidth>{
                                0: FixedColumnWidth(100),
                                1: FixedColumnWidth(15),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    const Text('Tgl Pengajuan', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    if (a.tanggal != null) Text(formatDate(a.tanggal!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                    if (a.tanggal == null) const Text("", style: TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Tgl Acc', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    if (a.tglAcc != null) Text(formatDate(a.tglAcc!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                    if (a.tglAcc == null) const Text("", style: TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Jam Mulai', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.jamMulai!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Jam Selesai', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.jamSelesai!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Jam Acc', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.jumlahJamAcc!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Total Jam', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.jumlahJam! + " jam", style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Kategori', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.kategori! , style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Jenis', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.jenis! , style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Keterangan', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.keterangan!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Feedback', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.feedback!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
