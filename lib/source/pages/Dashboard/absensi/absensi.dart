part of '../../index.dart';

class AbsensiScreen extends StatefulWidget {
  const AbsensiScreen({super.key});

  @override
  State<AbsensiScreen> createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  TextEditingController controllerNote = TextEditingController(text: "-");
  late final MapController mapController;
  // String tipeScan = "Visit";
  int tipeScan = 1;

  // void changeTipe(value) {
  //   setState(() {
  //     if (value == 1) {
  //       tipeScan = "Masuk";
  //     } else if (value == 2) {
  //       tipeScan = "Pulang";
  //     } else if (value == 3) {
  //       tipeScan = "Lembur Masuk";
  //     } else if (value == 4) {
  //       tipeScan = "Lembur Pulang";
  //     } else if (value == 5) {
  //       tipeScan = "Visit";
  //     }
  //   });
  // }

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
      BlocProvider.of<PostAbsensiCubit>(context).postAbsensi(gambar, lat, long, controllerNote.text, tipeScan, context);
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MarkerLocationCubit>(context).getCurrentLocation();
    mapController = MapController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Absensi"),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<MarkerLocationCubit>(context).getCurrentLocation();
              },
              icon: const Icon(Icons.pin_drop))
        ],
      ),
      body: BlocListener<PostAbsensiCubit, PostAbsensiState>(
        listener: (context, state) {
          if (state is PostAbsensiLoading) {
            MyDialog.dialogLoading(context);
          }
          if (state is PostAbsensiFailed) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 403) {
              MyDialog.dialogAlert(context, "This user does not have access.");
            } else if (statusCode == 400) {
              MyDialog.dialogAlert(context, data['message']);
            } else {
              MyDialog.dialogAlert(context, data['errors']);
            }
          }
          if (state is PostAbsensiLoaded) {
            Navigator.of(context).pop();
            var data = state.json;
            MyDialog.dialogSuccess(context, data['message'], onPressedOk: () {
              Navigator.pushNamedAndRemoveUntil(context, dashboardScreen, (Route<dynamic> route) => false);
              setState(() {
                selectedIndex = 1;
              });
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
                  mapController: mapController,
                  options: MapOptions(initialCenter: LatLng(latitude, longitude), initialZoom: 15),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.sihr.sihr',
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
                          AutoSizeText(place.street!, style: const TextStyle(fontFamily: 'JakartaSansBold', fontSize: 13), maxLines: 2),
                          const SizedBox(width: 4),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const SizedBox(width: 4),
                          const Icon(Icons.circle, size: 23),
                          const SizedBox(width: 8),
                          AutoSizeText(place.name!, style: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 12), maxLines: 1),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Tipe Absen", style: TextStyle(fontFamily: 'MontserratMedium')),
                                Row(
                                  children: [
                                    BlocBuilder<JenisAbsenCubit, JenisAbsenState>(
                                      builder: (context, state) {
                                        if (state is JenisAbsenLoading) {
                                          return Container();
                                        }
                                        if (state is JenisAbsenFailed) {
                                          return Container();
                                        }
                                        if (state is JenisAbsenLoaded == false) {
                                          return Container();
                                        }
                                        var data = (state as JenisAbsenLoaded).model!;
                                        return DropdownButton(
                                            value: tipeScan,
                                            items: data.data!.map((e) {
                                              return DropdownMenuItem(value: e.id!, child: Text(e.namaAbsen!));
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                tipeScan = value!;
                                              });
                                            });
                                        // return PopupMenuButton(
                                        //   child: Icon(Icons.arrow_drop_down),
                                        //   itemBuilder: (context) => data.data!.map((e) {
                                        //     return PopupMenuItem(
                                        //       onTap: () {
                                        //         changeTipe(1);
                                        //         tipeScan = e.namaAbsen!;
                                        //       },
                                        //       value: e.id,
                                        //       child: Text("${e.namaAbsen!}", style: TextStyle(fontFamily: 'MontserratSemiBold')),
                                        //     );
                                        //   }).toList(),
                                        // itemBuilder: (context) => [
                                        //   PopupMenuItem(
                                        //     onTap: () {
                                        //       changeTipe(1);
                                        //     },
                                        //     value: 1,
                                        //     child: Text("Absen Masuk", style: TextStyle(fontFamily: 'MontserratSemiBold')),
                                        //   ),
                                        //   PopupMenuItem(
                                        //     onTap: () {
                                        //       changeTipe(2);
                                        //     },
                                        //     value: 2,
                                        //     child: Text("Absen Pulang", style: TextStyle(fontFamily: 'MontserratSemiBold')),
                                        //   ),
                                        //   PopupMenuItem(
                                        //     onTap: () {
                                        //       changeTipe(3);
                                        //     },
                                        //     value: 3,
                                        //     child: Text("Lembur Masuk", style: TextStyle(fontFamily: 'MontserratSemiBold')),
                                        //   ),
                                        //   PopupMenuItem(
                                        //     onTap: () {
                                        //       changeTipe(4);
                                        //     },
                                        //     value: 4,
                                        //     child: Text("Lembur Pulang", style: TextStyle(fontFamily: 'MontserratSemiBold')),
                                        //   ),
                                        //   PopupMenuItem(
                                        //     onTap: () {
                                        //       changeTipe(4);
                                        //     },
                                        //     value: 4,
                                        //     child: Text("Visit", style: TextStyle(fontFamily: 'MontserratSemiBold')),
                                        //   ),
                                        // ],
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          color: const Color(0XFFF5F5F5),
                          padding: const EdgeInsets.only(top: 20, bottom: 10, left: 12, right: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Catatan", style: TextStyle(fontFamily: 'MontserratMedium')),
                              CustomField(
                                controller: controllerNote,
                              )
                            ],
                          ),
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
