part of '../../index.dart';

class SlipGajiScreen extends StatefulWidget {
  const SlipGajiScreen({super.key});

  @override
  State<SlipGajiScreen> createState() => _SlipGajiScreenState();
}

class _SlipGajiScreenState extends State<SlipGajiScreen> {
  var year, month, nameMonth;
  void selectMonth() {
    pickMonth(context).then((value) {
      if (value != null) {
        var monthFormat = DateFormat.MMMM().format(value);
        setState(() {
          month = value.toString().split(' ')[0].split('-')[1];
          year = value.toString().split(' ')[0].split('-')[0];
          nameMonth = monthFormat;
          BlocProvider.of<GetSlipGajiCubit>(context).getSlipGaji(month, year, context);
        });
      }
    });
  }

  void showSlipGaji(id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    print("");
    print("https://hris.rsuumc.com/payroll/print-slip/$id?token=$token");
    print("");
    if (!await launchUrl(Uri.parse("https://hris.rsuumc.com/payroll/print-slip/$id?token=${token!}"))) {
      throw Exception('Could not launch URL');
    }
  }

  void downloadSlipGaji(data) async {
    // Directory? targetPath = await getApplicationDocumentsDirectory();
    Directory? targetPath = Directory('/storage/emulated/0/Download');
    var targetFileName = "SlipGaji-${data.pegawai.nama}-$nameMonth $year";

    bool granted = await requestStoragePermission();
    const snackBars = SnackBar(content: Text('Loading...'));
    ScaffoldMessenger.of(context).showSnackBar(snackBars);
    if (!granted) {
      // Tampilkan notifikasi atau dialog
      print("Akses penyimpanan diperlukan untuk menyimpan file PDF.");
      MyDialog.dialogAlert(context, "Akses penyimpanan diperlukan untuk menyimpan file PDF.");
      return;
    }
    String base64Logo = await assetImageToBase64('assets/images/copy.png');
    String base64LogoIcon = await assetImageToBase64('assets/images/logoapk.png');
    final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
      htmlContent: SlipGaji.htmlSlipGaji(data, nameMonth, year, base64Logo, base64LogoIcon),
      printPdfConfiguration: PrintPdfConfiguration(
        // targetDirectory: targetPath!.path,
        targetDirectory: targetPath!.path,
        targetName: targetFileName,
        printSize: PrintSize.A4,
        printOrientation: PrintOrientation.Portrait,
      ),
    );
    print(generatedPdfFile.path);
    const snackBar = SnackBar(content: Text('Success download Slip Gaji'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteCustom2,
        title: const Text("Slip Gaji"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: selectMonth,
        child: const Icon(Icons.search, color: Colors.white),
      ),
      body: BlocConsumer<GetSlipGajiCubit, GetSlipGajiState>(
        listener: (context, state) {
          if (state is GetSlipGajiFailed) {
            var data = state.json;
            if (data == null) {
              MyDialog.dialogAlert(context, "Slip Gaji di bulan ini kosong");
            }
          }
        },
        builder: (context, state) {
          if (state is GetSlipGajiLoading) {
            return Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12),
              child: Column(
                children: [SizedBox(height: 120, child: Skeleton.skeleton1())],
              ),
            );
          }
          if (state is GetSlipGajiFailed) {
            var data = state.json;
            print(data);
            if (data != null) {
              return Center(child: Text(data['message']));
            }

            return Center(child: Text(""));
          }
          if (state is GetSlipGajiLoaded == false) {
            return Container();
          }
          var data = (state as GetSlipGajiLoaded).modelpayroll;
          // var idPegawai = (state).idPegawai;
          // List datafilter = data!.dataSlipgaji!.where((e) => e.idPegawai == idPegawai).toList();
          // if (datafilter.isEmpty) {
          //   return const Center(child: Text("Data Kosong"));
          // }
          return Container(
            padding: const EdgeInsets.all(12),
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                BlocProvider.of<GetSlipGajiCubit>(context).getSlipGaji(month, year, context);
              },
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data!.pegawai.nama, style: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                                const SizedBox(height: 4),
                                Text(data!.pegawai!.jabatan, style: const TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 15)),
                                // Text(data!.payroll![0].noreff!, style: const TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 14)),
                              ],
                            ),
                            Text("$nameMonth $year", style: const TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 15)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Divider(color: Colors.grey.shade500, height: 3),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: whiteCustom2,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 1.3, spreadRadius: 1.3, offset: Offset(1, 3))]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pendapatan Gaji", style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16, color: Colors.grey.shade500)),
                              const SizedBox(height: 6),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.pendapatan!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    var a = data.pendapatan![index];
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 3, child: AutoSizeText(a.komponenGaji!.namaKomponen!, style: const TextStyle(fontSize: 13), maxLines: 1)),
                                        Expanded(child: Text(formatRupiah(a.nilai!), style: const TextStyle(fontSize: 13))),
                                      ],
                                    );
                                  }),
                              const SizedBox(height: 4),
                              Divider(color: Colors.grey.shade500, height: 3),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(flex: 3, child: AutoSizeText("Total", style: const TextStyle(fontSize: 14), maxLines: 1)),
                                  Expanded(child: Text(formatRupiah(data.payroll![0].pendapatan!), style: const TextStyle(fontSize: 14))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: whiteCustom2,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 1.3, spreadRadius: 1.3, offset: Offset(1, 3))]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Potongan Gaji", style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16, color: Colors.grey.shade500)),
                              const SizedBox(height: 6),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.potongan!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    var a = data.potongan![index];
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 3, child: AutoSizeText(a.komponenGaji!.namaKomponen!, style: const TextStyle(fontSize: 13), maxLines: 1)),
                                        Expanded(child: Text(formatRupiah(a.nilai!), style: const TextStyle(fontSize: 13))),
                                      ],
                                    );
                                  }),
                              const SizedBox(height: 4),
                              Divider(color: Colors.grey.shade500, height: 3),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(flex: 3, child: AutoSizeText("Total", style: const TextStyle(fontSize: 14), maxLines: 1)),
                                  Expanded(child: Text(formatRupiah(data.payroll![0].potongan!), style: const TextStyle(fontSize: 14))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: whiteCustom2,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 1.3, spreadRadius: 1.3, offset: Offset(1, 3))]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText("Total Gaji", style: const TextStyle(fontSize: 15), maxLines: 1),
                              Text(formatRupiah(data.payroll![0].pendapatan! - data.payroll![0].potongan!), style: const TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: CustomButton2(
                            onTap: () {
                              downloadSlipGaji(data);
                            },
                            text: "Download Slip Gaji",
                            backgroundColor: hijauTeal1,
                            textStyle: const TextStyle(color: whiteCustom, fontSize: 20, fontFamily: 'JakartaSansSemiBold'),
                            roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              // child: ListView.builder(
              //   itemCount: data!.dataSlipgaji!.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     var a = data!.dataSlipgaji![index];
              //     return Container(
              //       margin: const EdgeInsets.only(top: 10),
              //       decoration: BoxDecoration(color: hijauDark, borderRadius: BorderRadius.circular(12)),
              //       child: Container(
              //         margin: const EdgeInsets.only(left: 12),
              //         padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
              //         decoration: const BoxDecoration(
              //           color: whiteCustom2,
              //           borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(a.noreff!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
              //                 Text("${a.bulan} - ${a.tahun}", style: const TextStyle(fontFamily: 'MontserratSemiBold')),
              //               ],
              //             ),
              //             const SizedBox(height: 8),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               children: [
              //                 CustomButton2(
              //                   onTap: () {
              //                     // showSlipGaji(a.id);
              //                     // setState(() {
              //                     //   id_slip_gaji = a.id;
              //                       Navigator.pushNamed(context, detailSlipgajiScreen);
              //                     // });
              //                   },
              //                   text: "Lihat Slip Gaji",
              //                   backgroundColor: Colors.blue[600],
              //                   textStyle: const TextStyle(color: Colors.white),
              //                   roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              //                 ),
              //               ],
              //             )
              //           ],
              //         ),
              //       ),
              //     );

              //   },
              // ),
            ),
          );
        },
      ),
    );
  }
}
