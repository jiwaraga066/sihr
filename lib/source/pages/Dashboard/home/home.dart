part of '../../index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> key = GlobalKey();

  Future handleCheck() async {
    BlocProvider.of<CheckPermissionCubit>(context).checkPermissionGranted(context);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).session(context);

    // BlocProvider.of<GetPegawaiCubit>(context).getPegawai(context);
    // BlocProvider.of<GetSisaAbsenCubit>(context).getSisaAbsensi(context);
    // BlocProvider.of<JenisAbsenCubit>(context).getJenisAbsensi(context);
    // BlocProvider.of<GetShiftCubit>(context).getShift(context);
    WidgetsBinding.instance.addPostFrameCallback((context) {
      handleCheck();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Si - HR", style: TextStyle(color: Colors.indigo, fontFamily: 'JakartaSansMedium', fontSize: 25)),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoaded) {
            BlocProvider.of<GetPegawaiCubit>(context).getPegawai(context);
            BlocProvider.of<GetSisaAbsenCubit>(context).getSisaAbsensi(context);
            BlocProvider.of<JenisAbsenCubit>(context).getJenisAbsensi(context);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }
          if (state is AuthLoaded == false) {
            return Container(
              child: const Text("Raga"),
            );
          }
          var load = (state as AuthLoaded).json;
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              // BlocProvider.of<AuthCubit>(context).session(context);
              BlocProvider.of<GetPegawaiCubit>(context).getPegawai(context);
              BlocProvider.of<GetSisaAbsenCubit>(context).getSisaAbsensi(context);
              BlocProvider.of<JenisAbsenCubit>(context).getJenisAbsensi(context);
            },
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                        height: 65,
                        decoration:
                            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.withOpacity(0.5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset("assets/images/avatar.png"),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Hi", style: TextStyle(fontFamily: 'MontserratMedium', fontSize: 14)),
                                      AutoSizeText(load['username']!, style: const TextStyle(fontSize: 16, fontFamily: 'MontserratSemiBold'), maxLines: 1),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const WidgetCardHome(),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: AutoSizeText('Pusat Navigasi', style: TextStyle(fontSize: 18, fontFamily: 'JakartaSansSemibold'), maxLines: 1),
                      ),
                      const SizedBox(height: 10),
                      const WidgetMenuUtama(),
                      const SizedBox(height: 20),
                    ],
                  );
                }),
          );
        },
      ),
    );
  }
}
