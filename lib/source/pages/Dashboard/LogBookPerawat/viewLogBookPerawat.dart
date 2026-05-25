part of '../../index.dart';

class LogBookPerawatScreen extends StatefulWidget {
  const LogBookPerawatScreen({super.key});

  @override
  State<LogBookPerawatScreen> createState() => _LogBookPerawatScreenState();
}

class _LogBookPerawatScreenState extends State<LogBookPerawatScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetLogBookPerawatCubit>(context).getLogBookPerawat(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log Book", style: TextStyle(fontFamily: 'JakartaSansMedium')),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, createlogbookPerawatScreen);
          },
          child: const Icon(Icons.add, color: Colors.white)),
      body: BlocBuilder<GetLogBookPerawatCubit, GetLogBookPerawatState>(
        builder: (context, state) {
          if (state is GetLogBookPerawatLoading) {
            return Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12),
              child: Column(
                children: [SizedBox(height: 120, child: Skeleton.skeleton1())],
              ),
            );
          }
          if (state is GetLogBookPerawatFailed) {
            var data = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 403) {
              return const Center(child: Text("This user does not have access."));
            } else {
              return Center(child: Text(data['message'].toString()));
            }
          }
          if (state is GetLogBookPerawatLoaded == false) {
            return Container();
          }
          var data = (state as GetLogBookPerawatLoaded).model;

          return Container(
            padding: const EdgeInsets.all(12),
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                BlocProvider.of<GetLogBookPerawatCubit>(context).getLogBookPerawat(context);
              },
              child: ListView.builder(
                itemCount: data!.dataLogbook!.length,
                itemBuilder: (BuildContext context, int index) {
                  var a = data.dataLogbook![index];
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
                                      child: const Text("Verified",
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
                            ],
                          ),
                          const SizedBox(height: 4),
                          Table(
                            border: TableBorder.all(style: BorderStyle.none),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(100),
                              1: FixedColumnWidth(15),
                            },
                            children: [
                              TableRow(
                                children: [
                                  const Text('Tgl Pembuatan', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(formatDate(a.tanggal!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Karyawan', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(a.pegawai!.nama!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Log Book', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(a.mlogbook!.namaLog!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
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
                                  const Text('Jumlah', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  Text(a.jumlah!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                              TableRow(
                                children: [
                                  const Text('Jenis', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                  if (a.jenis! == "") const Text("", style: TextStyle(fontFamily: 'JakartaSansMedium')),
                                  if (a.jenis!.contains("mandiri")) const Text("Mandiri", style: TextStyle(fontFamily: 'JakartaSansMedium')),
                                  if (a.jenis!.contains("supervisi")) const Text("supervisi", style: TextStyle(fontFamily: 'JakartaSansMedium')),
                                ],
                              ),
                              const TableRow(
                                children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton2(
                              onTap: () {
                                Navigator.pushNamed(context, updatelogbookPerawatScreen);
                                setState(() {
                                  idlogbook = a.id;
                                  mlogbook = a.idMLogbook;
                                  tanggalLogbookPerawat = a.tanggal.toString().split(' ')[0];
                                  jumlahLogBookPerawat = a.jumlah;
                                  valueketerangan = a.keterangan;
                                  valuejenislogbook = a.jenis;
                                  valuestatus = a.status;
                                  print(a.jenis);
                                });
                              },
                              text: "Edit LogBook",
                              backgroundColor: Colors.deepPurple,
                              textStyle: const TextStyle(color: Colors.white),
                              roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
