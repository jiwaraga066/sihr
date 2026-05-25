part of '../../index.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Widget tipeUmum(BuildContext context) {
    return BlocBuilder<GetPengumumanCubit, GetPengumumanState>(
      builder: (context, state) {
        if (state is GetPengumumanLoading) {
          return Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12),
            child: Column(
              children: [SizedBox(height: 120, child: Skeleton.skeleton1())],
            ),
          );
        }
        if (state is GetPengumumanFailed) {
          var data = state.json;
          var statusCode = state.statusCode;
          if (statusCode == 403) {
            return const Center(child: Text("This user does not have access."));
          } else {
            return Center(child: Text(data['message'].toString()));
          }
        }
        if (state is GetPengumumanLoaded == false) {
          return Container();
        }
        var data = (state as GetPengumumanLoaded).model;
        List datafilter = data!.dataPengumuman!.where((e) => e.jenis!.status == 1 && e.tipe == "Umum").toList();
        if (datafilter.isEmpty) {
          return const Center(child: Text("Data Kosong"));
        }
        return Container(
          padding: const EdgeInsets.all(12),
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              BlocProvider.of<GetPengumumanCubit>(context).getPengumuman(context);
            },
            child: ListView.builder(
              itemCount: datafilter.length,
              itemBuilder: (context, index) {
                var a = datafilter[index];
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(color: hijauLight2, borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      color: whiteCustom2,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(a.namaPengumuman!, style: const TextStyle(fontFamily: 'MontserratSemiBold', fontSize: 12)),
                          subtitle: Text(a.isi!, style: const TextStyle(fontFamily: 'MontserratMedium', fontSize: 11)),
                          trailing: Text(formatDate(a.tanggal), style: const TextStyle(fontFamily: 'MontserratMedium', fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget tipeKhusus(BuildContext context) {
    return BlocBuilder<GetPengumumanCubit, GetPengumumanState>(
      builder: (context, state) {
        if (state is GetPengumumanLoading) {
          return Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12),
            child: Column(
              children: [SizedBox(height: 120, child: Skeleton.skeleton1())],
            ),
          );
        }
        if (state is GetPengumumanFailed) {
          var data = state.json;
          var statusCode = state.statusCode;
          if (statusCode == 403) {
            return const Center(child: Text("This user does not have access."));
          } else {
            return Center(child: Text(data['message'].toString()));
          }
        }
        if (state is GetPengumumanLoaded == false) {
          return Container();
        }
        var data = (state as GetPengumumanLoaded).model;
        List datafilter = data!.dataPengumuman!.where((e) => e.jenis!.status == 1 && e.tipe == "Khusus").toList();
        if (datafilter.isEmpty) {
          return const Center(child: Text("Data Kosong"));
        }
        return Container(
          padding: const EdgeInsets.all(12),
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              BlocProvider.of<GetPengumumanCubit>(context).getPengumuman(context);
            },
            child: ListView.builder(
              itemCount: datafilter.length,
              itemBuilder: (context, index) {
                var a = datafilter[index];
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(color: hijauLight2, borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      color: whiteCustom2,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(a.namaPengumuman!, style: const TextStyle(fontFamily: 'MontserratSemiBold', fontSize: 12)),
                          subtitle: Text(a.isi!, style: const TextStyle(fontFamily: 'MontserratMedium', fontSize: 11)),
                          trailing: Text(formatDate(a.tanggal), style: const TextStyle(fontFamily: 'MontserratMedium', fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void showImage(gambar) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Check In Preview", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Image.network(
                  '$gambar',
                  height: 400,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 50),
                          SizedBox(height: 10),
                          Text("Gambar gagal dimuat", style: TextStyle(fontSize: 16, color: Colors.red)),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget tipeHistory(BuildContext context) {
    return BlocBuilder<GetPengumumanPesertaCubit, GetPengumumanPesertaState>(
      builder: (context, state) {
        if (state is GetPengumumanPesertaLoading) {
          return Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12),
            child: Column(
              children: [SizedBox(height: 120, child: Skeleton.skeleton1())],
            ),
          );
        }
        if (state is GetPengumumanPesertaFailed) {
          var data = state.json;
          var statusCode = state.statusCode;
          if (statusCode == 403) {
            return const Center(child: Text("This user does not have access."));
          }
          if (statusCode == 404) {
            return const Center(child: Text("Not Found"));
          } else {
            return Center(child: Text(data['message'].toString()));
          }
        }
        if (state is GetPengumumanPesertaLoaded == false) {
          return Container();
        }
        var data = (state as GetPengumumanPesertaLoaded).model;

        return Container(
          padding: const EdgeInsets.all(12),
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              BlocProvider.of<GetPengumumanPesertaCubit>(context).getPengumumanPeserta(context);
            },
            child: ListView.builder(
              itemCount: data!.data!.length,
              itemBuilder: (context, index) {
                var a = data.data![index];
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(color: hijauLight2, borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      color: whiteCustom2,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(a.pengumuman!.namaPengumuman!, style: const TextStyle(fontFamily: 'MontserratSemiBold', fontSize: 12)),
                          subtitle: Text(a.pengumuman!.isi!, style: const TextStyle(fontFamily: 'MontserratMedium', fontSize: 11)),
                          trailing: Text(formatDate(a.pengumuman!.tanggal!), style: const TextStyle(fontFamily: 'MontserratMedium', fontSize: 12)),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Table(
                            border: TableBorder.all(style: BorderStyle.none),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(100),
                              1: FixedColumnWidth(15),
                            },
                            children: const [
                              // TableRow(
                              //   children: [
                              //     const Text('Resume', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                              //     const Text(':', style: TextStyle(fontFamily: 'JakartaSansSemiBold')),
                              //     Text(a.resume!, style: const TextStyle(fontFamily: 'JakartaSansMedium')),
                              //   ],
                              // ),
                              // const TableRow(
                              //   children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (a.cekin!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: CustomButton2(
                                onTap: () {
                                  showImage(a.cekin!);
                                },
                                text: "Lihat Foto",
                                backgroundColor: biru,
                                textStyle: const TextStyle(color: whiteCustom, fontSize: 15, fontFamily: 'JakartaSansSemiBold'),
                                roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: CustomButton2(
                              onTap: () {
                                setState(() {
                                  idNews = a.id;
                                  statusAbsenNews = "Resume";
                                  valueResume = a.resume!;
                                });
                                Navigator.pushNamed(context, newsCheckinScreen);
                              },
                              text: "Resume",
                              backgroundColor: biru,
                              textStyle: const TextStyle(color: whiteCustom, fontSize: 15, fontFamily: 'JakartaSansSemiBold'),
                              roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (a.cekin!.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: CustomButton2(
                                onTap: () {
                                  setState(() {
                                    idNews = a.id;
                                    statusAbsenNews = "CheckIn";
                                  });
                                  Navigator.pushNamed(context, newsCheckinScreen);
                                },
                                text: "Check In",
                                backgroundColor: biru,
                                textStyle: const TextStyle(color: whiteCustom, fontSize: 15, fontFamily: 'JakartaSansSemiBold'),
                                roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetPengumumanCubit>(context).getPengumuman(context);
    BlocProvider.of<GetPengumumanPesertaCubit>(context).getPengumumanPeserta(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            indicatorColor: hijau,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(child: Text("UMUM", style: TextStyle(fontFamily: 'JakartaSansBold'))),
              // Tab(child: Text("KHUSUS", style: TextStyle(fontFamily: 'JakartaSansBold'))),
              Tab(child: Text("KHUSUS", style: TextStyle(fontFamily: 'JakartaSansBold'))),
            ],
          ),
          title: const Text('Berita', style: TextStyle(fontFamily: 'JakartaSansMedium')),
        ),
        body: TabBarView(
          children: [
            tipeUmum(context),
            // tipeKhusus(context),
            tipeHistory(context),
          ],
        ),
      ),
    );
  }
}
