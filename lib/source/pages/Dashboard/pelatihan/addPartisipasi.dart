part of '../../index.dart';

class AddPartisipasiPelatihanScreen extends StatefulWidget {
  const AddPartisipasiPelatihanScreen({super.key});

  @override
  State<AddPartisipasiPelatihanScreen> createState() => _AddPartisipasiPelatihanScreenState();
}

class _AddPartisipasiPelatihanScreenState extends State<AddPartisipasiPelatihanScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController controllerWaktuMulai = TextEditingController();
  TextEditingController controllerWaktuSelesai = TextEditingController();
  var valueIdPelatihan;
  String? waktuMulai, waktuSelesai;

  XFile? gambar;
  void pickImage() async {
    selectPhoto(source: ImageSource.camera).then((value) {
      setState(() {
        gambar = value;
        print("gambar: ${gambar!.path}");
      });
    });
  }

  void proses(lat, long) {
    if (gambar == null) {
      MyDialog.dialogAlert(context, "Maaf, anda belum upload foto");
    } else {
      BlocProvider.of<AbsenPelatihanCubit>(context).absenPartisipasi(context, gambar, lat, long);
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MarkerLocationCubit>(context).getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: biru,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Form Partisipasi Pelatihan", style: TextStyle(color: Colors.white)),
      ),
      body: BlocListener<AbsenPelatihanCubit, AbsenPelatihanState>(
        listener: (context, state) {
          if (state is AbsenPelatihanLoading) {
            MyDialog.dialogLoading(context);
          }
          if (state is AbsenPelatihanFailed) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 403) {
              MyDialog.dialogAlert(context, "This user does not have access.");
            } else {
              MyDialog.dialogAlert(context, data['errors'].toString());
            }
          }
          if (state is AbsenPelatihanLoaded) {
            Navigator.of(context).pop();
            var data = state.json;
            MyDialog.dialogSuccess(context, data['message'], onPressedOk: () {
              Navigator.of(context).pop();
              BlocProvider.of<PelatihanCubit>(context).getPelatihan(context);
            });
          }
        },
        child: BlocBuilder<MarkerLocationCubit, MarkerLocationState>(
          builder: (context, state) {
            if (state is MarkerLocationLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is MarkerLocationFailed) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(state.message)],
                ),
              );
            }
            if (state is MarkerLocationLoaded == false) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            var latitude = (state as MarkerLocationLoaded).latitude!;
            var longitude = (state).longitude!;
            var place = (state).myPlacement![0];
            return Stack(
              children: [
                FlutterMap(
                  options: MapOptions(initialCenter: LatLng(latitude, longitude), initialZoom: 15),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    // LOKASI HOSPITAL
                    CircleLayer(
                      circles: [
                        CircleMarker(
                          point: LatLng(latitudePlace, longitudePlace),
                          radius: 250,
                          useRadiusInMeter: true,
                          color: Colors.red[200]!.withOpacity(0.5),
                          borderColor: Colors.red.withOpacity(0.5),
                          borderStrokeWidth: 2,
                        ),
                      ],
                    ),
                    MarkerLayer(markers: [
                      Marker(point: LatLng(latitudePlace, longitudePlace), width: 50, height: 50, child: Image.asset("assets/images/hospital.png", height: 50)),
                    ]),
                    // LOKASI USER
                    CircleLayer(
                      circles: [
                        CircleMarker(
                          point: LatLng(latitude, longitude),
                          radius: 250,
                          useRadiusInMeter: true,
                          color: Colors.blue[200]!.withOpacity(0.5),
                          borderColor: Colors.blue.withOpacity(0.5),
                          borderStrokeWidth: 2,
                        ),
                      ],
                    ),
                    MarkerLayer(markers: [
                      Marker(point: LatLng(latitude, longitude), width: 50, height: 50, child: Image.asset("assets/images/pin.png", height: 50)),
                    ]),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.only(top: 15, bottom: 15, left: 12, right: 12),
                  decoration:
                      BoxDecoration(color: whiteCustom2, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black.withOpacity(0.5))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 4),
                          const Icon(FontAwesomeIcons.circle, size: 23),
                          const SizedBox(width: 8),
                          AutoSizeText(place.street!, style: const TextStyle(fontFamily: 'JakartaSansBold'), maxLines: 2),
                          const SizedBox(width: 4),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const SizedBox(width: 4),
                          const Icon(Icons.circle, size: 23),
                          const SizedBox(width: 8),
                          AutoSizeText(place.name!, style: const TextStyle(fontFamily: 'JakartaSansSemiBold'), maxLines: 1),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    // height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: pickImage,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Text("Ambil Foto"),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(color: biru, borderRadius: BorderRadius.circular(100)),
                                        child: const Icon(FontAwesomeIcons.camera, color: Colors.white),
                                      ),
                                      const Icon(Icons.arrow_drop_down_outlined),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: CustomButton2(
                            onTap: () {
                              proses(latitude, longitude);
                            },
                            text: "PROSES",
                            textStyle: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'JakartaSansSemiBold'),
                            backgroundColor: biru,
                            roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
