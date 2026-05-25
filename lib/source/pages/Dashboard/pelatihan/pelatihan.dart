part of '../../index.dart';

class PelatihanScreen extends StatefulWidget {
  const PelatihanScreen({super.key});

  @override
  State<PelatihanScreen> createState() => _PelatihanScreenState();
}

class _PelatihanScreenState extends State<PelatihanScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PelatihanCubit>(context).getPelatihan(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pelatihan"),
      ),
      body: BlocBuilder<PelatihanCubit, PelatihanState>(
        builder: (context, state) {
          if (state is PelatihanLoading) {
            return Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12),
              child: Column(
                children: [SizedBox(height: 120, child: Skeleton.skeleton1())],
              ),
            );
          }
          if (state is PelatihanFailed) {
            var data = state.json;
            return const Center(child: Text("This user does not have access."));
          }
          if (state is PelatihanLoaded == false) {
            return Container();
          }
          var data = (state as PelatihanLoaded).modelPelatihan;
          var idPegawai = (state).idPegawai;
          List datafilter = data!.dataPelatihan!.where((e) => e.idPegawai == idPegawai).toList();
          if (datafilter.isEmpty) {
            return const Center(child: Text("Data Kosong"));
          }
          return Container(
            padding: const EdgeInsets.all(12),
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                BlocProvider.of<PelatihanCubit>(context).getPelatihan(context);
              },
              child: ListView.builder(
                itemCount: datafilter.length,
                itemBuilder: (BuildContext context, int index) {
                  var a = datafilter[index];
                  if (a.pelatihan != null) {
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
                                Text(a.pelatihan!.namaPelatihan!, style: const TextStyle(fontFamily: 'MontserratSemiBold')),
                                Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                                    child: Text(a.status!, style: const TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14, color: Colors.white))),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text("${a.pegawai!.nama!}", style: const TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 15)),
                            Table(
                              border: TableBorder.all(style: BorderStyle.none),
                              columnWidths: const <int, TableColumnWidth>{
                                0: FixedColumnWidth(100),
                                1: FixedColumnWidth(15),
                              },
                              children: [
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Jenis', style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 13)),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text("${a.pelatihan!.jenispelatihan!.namaJenis}", style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Mulai Pelatihan', style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 13)),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(formatDate2(a.pelatihan!.tanggalMulai!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Selesai Pelatihan', style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 13)),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(formatDate2(a.pelatihan!.tanggalSelesai!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Tempat', style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 13)),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.pelatihan!.tempat!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Tipe', style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 13)),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    if (a.pelatihan!.tipe!.contains('internal'))
                                      Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(color: Colors.green[600], borderRadius: BorderRadius.circular(8)),
                                          child: Text(a.pelatihan!.tipe!, style: const TextStyle(fontFamily: 'JakartaSansMedium', color: Colors.white))),
                                    if (a.pelatihan!.tipe!.contains('internal') == false)
                                      Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(color: Colors.red[600], borderRadius: BorderRadius.circular(8)),
                                          child: Text(a.pelatihan!.tipe!, style: const TextStyle(fontFamily: 'JakartaSansMedium', color: Colors.white))),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Jumlah Jam', style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 13)),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.pelatihan!.jumlahJam!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('SKP', style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 13)),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.pelatihan!.jumlahSkp.toString(), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                // TableRow(
                                //   children: [
                                //     const Text('Resume', style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 13)),
                                //     const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                //     Text(a.resume!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                //   ],
                                // ),
                                // const TableRow(
                                //   children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                // ),
                                TableRow(
                                  children: [
                                    const Text('Penyelenggara', style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 13)),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.pelatihan!.penyelenggara!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Deskripsi', style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 13)),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.pelatihan!.deskripsi!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // if (a.status != "Mengikuti")
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: CustomButton2(
                                backgroundColor: hijauLight,
                                onTap: () {
                                  setState(() {
                                    id_pelatihan = a.idPelatihan;
                                    id_partisipasi = a.id;
                                  });
                                  Navigator.pushNamed(context, addPartisipasiScreen);
                                },
                                text: "Check In",
                                textStyle: const TextStyle(fontFamily: 'MontserratMedium', color: Colors.white),
                                roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                            const SizedBox(height: 12),
                             if (a.status == "Mengikuti")
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: CustomButton2(
                                backgroundColor: const Color(0XFF78B3CE),
                                onTap: () {
                                  setState(() {
                                    id_pelatihan = a.idPelatihan;
                                    id_partisipasi = a.id;
                                    valueResume = a.resume!;
                                  });
                                  print(a.id);
                                  Navigator.pushNamed(context, addResumePelatihanScreen);
                                },
                                text: "Resume",
                                textStyle: const TextStyle(fontFamily: 'MontserratMedium', color: Colors.white),
                                roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
