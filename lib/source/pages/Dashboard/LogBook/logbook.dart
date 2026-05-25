part of '../../index.dart';

class LogBookScreen extends StatefulWidget {
  const LogBookScreen({super.key});

  @override
  State<LogBookScreen> createState() => _LogBookScreenState();
}

class _LogBookScreenState extends State<LogBookScreen> {
  void showUpload(link) async {
    if (!await launchUrl(Uri.parse("$link"))) {
      throw Exception('Could not launch $link');
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetLogBookCubit>(context).getLogBook(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log Book", style: TextStyle(fontFamily: 'JakartaSansMedium')),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, createlogbookScreen);
          },
          child: const Icon(Icons.add, color: Colors.white)),
      body: BlocBuilder<GetLogBookCubit, GetLogBookState>(
        builder: (context, state) {
          if (state is GetLogBookLoading) {
            return Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12),
              child: Column(
                children: [SizedBox(height: 120, child: Skeleton.skeleton1())],
              ),
            );
          }
          if (state is GetLogBookFailed) {
            var data = state.json;
          var statusCode = state.statusCode;
            if (statusCode == 403) {
              return const Center(child: Text("This user does not have access."));
            } else {
              return Center(child: Text(data['message'].toString()));
            }
          }
          if (state is GetLogBookLoaded == false) {
            return Container();
          }
          var data = (state as GetLogBookLoaded).model;
          var idPegawai = (state).idPegawai;
          List datafilter = data!.dataLogBook!.where((e) => e.idPegawai == idPegawai).toList();
          if (datafilter.isEmpty) {
            return const Center(child: Text("Data Kosong"));
          }
          return Container(
            padding: const EdgeInsets.all(12),
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                BlocProvider.of<GetLogBookCubit>(context).getLogBook(context);
              },
              child: ListView.builder(
                itemCount: datafilter.length,
                itemBuilder: (BuildContext context, int index) {
                  var a = datafilter[index];
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
                              const Text("Tanggal Pembuatan", style: TextStyle(fontFamily: 'MontserratSemiBold')),
                              Text(formatDate(a.tanggal!), style: const TextStyle(fontFamily: 'MontserratSemiBold')),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Table(
                            border: TableBorder.all(style: BorderStyle.none),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(100),
                              1: FixedColumnWidth(15),
                            },
                            children: [
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
                                  Text(a.namaLog!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
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
                            ],
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton2(
                              onTap: () {
                                showUpload(a.upload);
                              },
                              text: "Lihat Upload",
                              backgroundColor: Colors.indigo,
                              textStyle: const TextStyle(color: Colors.white),
                              roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton2(
                              onTap: () {
                                Navigator.pushNamed(context, updatelogbookScreen);
                                setState(() {
                                  idlogbook = a.id;
                                  namalog = a.namaLog;
                                  tanggalLogbook = a.tanggal.toString().split(' ')[0];
                                  keteranganlog = a.keterangan;
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
