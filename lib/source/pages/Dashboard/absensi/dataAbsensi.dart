part of '../../index.dart';

class DataAbsensiScreen extends StatefulWidget {
  const DataAbsensiScreen({super.key});

  @override
  State<DataAbsensiScreen> createState() => _DataAbsensiScreenState();
}

class _DataAbsensiScreenState extends State<DataAbsensiScreen> {
  TextEditingController controllerTanggalAwal = TextEditingController();
  TextEditingController controllerTanggalAkhir = TextEditingController();

  void pilihTanggalAwal() {
    pickDate(context).then((value) {
      if (value != null) {
        var date = DateFormat('yyyy-MM-dd').format(value);
        setState(() {
          controllerTanggalAwal.text = date;
        });
      }
    });
  }

  void pilihTanggalAkhir() {
    pickDate(context).then((value) {
      if (value != null) {
        var date = DateFormat('yyyy-MM-dd').format(value);
        setState(() {
          controllerTanggalAkhir.text = date;
        });
      }
    });
  }

  void filterTanggal() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pilih Tanggal Absen"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Tanggal Awal", style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
              const SizedBox(height: 12),
              CustomField(
                  readOnly: true,
                  controller: controllerTanggalAwal,
                  onTap: pilihTanggalAwal,
                  suffixIcon: const Icon(FontAwesomeIcons.calendar),
                  textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14)),
              const SizedBox(height: 20),
              const Text("Tanggal Akhir", style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
              const SizedBox(height: 12),
              CustomField(
                  readOnly: true,
                  controller: controllerTanggalAkhir,
                  onTap: pilihTanggalAkhir,
                  suffixIcon: const Icon(FontAwesomeIcons.calendar),
                  textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14)),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Tutup")),
            TextButton(
                onPressed: () {
                  BlocProvider.of<GetAbsensiCubit>(context).getAbsensi(context, controllerTanggalAwal.text, controllerTanggalAkhir.text);
                  Navigator.of(context).pop();
                },
                child: const Text("Cari")),
          ],
        );
      },
    );
  }

  void showFoto(foto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Foto Absensi"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: SizedBox(
                    height: 250,
                    width: 200,
                    child: Image.network(
                      foto!,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Image is fully loaded
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return const Center(
                          child: Icon(Icons.error, color: Colors.red, size: 50),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Tutup")),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAbsensiCubit>(context).initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Absensi", style: TextStyle(fontFamily: 'JakartaSansMedium')),
        actions: [IconButton(onPressed: filterTanggal, icon: const Icon(FontAwesomeIcons.filter))],
      ),
      body: BlocBuilder<GetAbsensiCubit, GetAbsensiState>(
        builder: (context, state) {
          if (state is GetAbsensiInitial) {
            return const Center(
              child: Text("Klik icon Filter untuk melihat Absensi"),
            );
          }
          if (state is GetAbsensiLoading) {
            return Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12),
              child: Column(
                children: [SizedBox(height: 120, child: Skeleton.skeleton1())],
              ),
            );
          }
          if (state is GetAbsensiFailed) {
            var data = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 403) {
              return const Center(child: Text("This user does not have access."));
            } else {
              return Center(child: Text(data['message'].toString()));
            }
          }
          if (state is GetAbsensiLoaded == false) {
            return Container();
          }
          var data = (state as GetAbsensiLoaded).model;
          var idPegawai = (state).idPegawai;
          List datafilter = data!.data!.where((e) => e.idPegawai == idPegawai).toList().reversed.toList();
          if (datafilter.isEmpty) {
            return const Center(child: Text("Data Kosong"));
          }
          return Container(
            padding: const EdgeInsets.all(12),
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                // BlocProvider.of<GetAbsensiCubit>(context).getAbsensi(context);
                BlocProvider.of<GetAbsensiCubit>(context).getAbsensi(context, controllerTanggalAwal.text, controllerTanggalAkhir.text);
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
                            Row(children: [
                              // if (a.)
                              Image.asset("assets/images/male.png"),
                              const SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(a.namaPegawai!, style: const TextStyle(fontFamily: 'MontserratSemiBold', fontSize: 13)),
                                ],
                              )
                            ]),
                            const SizedBox(height: 6),
                            Table(
                              border: TableBorder.all(style: BorderStyle.none),
                              columnWidths: const <int, TableColumnWidth>{
                                0: FixedColumnWidth(100),
                                1: FixedColumnWidth(15),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    const Text('Departemen', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text("${a.departement!}", style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Jabatan', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text("${a.jabatan!}", style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Jam Masuk', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    if (a.waktuMasuk!.isNotEmpty) AutoSizeText(a.waktuMasuk!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                    if (a.waktuMasuk!.isEmpty) const AutoSizeText("", style: TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Jam Pulang', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    if (a.waktuKeluar!.isNotEmpty) AutoSizeText(a.waktuKeluar!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                    if (a.waktuKeluar!.isEmpty) const AutoSizeText("Belum Pulang", style: TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Tgl Masuk', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    if (a.tanggal! != null) Text(formatDate(a.tanggal!), style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Jenis', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                    Text(a.shift!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                                  ],
                                ),
                                const TableRow(
                                  children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                ),
                                if (a.status == 0 && a.terlambat == 0)
                                  TableRow(
                                    children: [
                                      const Text('Status', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                      const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                      Text("Tepat Waktu", style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 12, color: Colors.blue[600])),
                                      //  Text(a.status.toString(), style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                      // if (a.status == 1)
                                      //   Text("Terlambat", style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 12, color: Colors.red[600])),
                                    ],
                                  ),
                                if (a.terlambat != 0)
                                  TableRow(
                                    children: [
                                      const Text('Status', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                      const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                      // Text("Tepat Waktu", style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 12, color: Colors.blue[600])),
                                      Text("Terlambat", style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 12, color: Colors.red[600])),
                                      //  Text(a.status.toString(), style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                                      // if (a.status == 1)
                                    ],
                                  ),
                              ],
                            ),

                            const SizedBox(height: 8),
                            InkWell(
                                onTap: () {
                                  showFoto(a.fotoUrl!);
                                },
                                child: const Text("Lihat Foto",
                                    style: TextStyle(fontFamily: 'JakartaSansMedium', color: Colors.blue, decoration: TextDecoration.underline))),
                            const SizedBox(height: 8),
                            // AutoSizeText(a.keterangan!, maxLines: 2, style: TextStyle(fontFamily: 'MontserratMedium', fontSize: 14)),
                            // const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
        },
      ),
    );
  }
}
