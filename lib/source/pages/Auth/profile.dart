part of '../index.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void logout() {
    MyDialog.dialogInfo(context, "Apakah anda ingin keluar ?", () {}, () {
      BlocProvider.of<AuthCubit>(context).logout(context);
    });
  }

  void cekcv(id) async {
    if (!await launchUrl(Uri.parse("https://hris.rsuumc.com/pegawai/$id"))) {
      throw Exception('Could not launch "https://hris.rsuumc.com/pegawai/$id"');
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetPegawaiCubit>(context).getPegawai(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile", style: TextStyle(fontFamily: 'JakartaSansMedium')),
      ),
      body: BlocBuilder<GetPegawaiCubit, GetPegawaiState>(
        builder: (context, state) {
          if (state is GetPegawaiLoading) {
            return Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
              child: Column(
                children: [
                  Skeleton.skeleton2(width: 160, height: 160),
                  const SizedBox(height: 28),
                  Skeleton.skeleton1(width: MediaQuery.of(context).size.width, height: 20),
                  const SizedBox(height: 28),
                  Skeleton.skeleton1(width: MediaQuery.of(context).size.width, height: 50),
                ],
              ),
            );
          }
          if (state is GetPegawaiLoaded == false) {
            return Container();
          }
          var data = (state as GetPegawaiLoaded).model;
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              BlocProvider.of<GetPegawaiCubit>(context).getPegawai(context);
            },
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      if (data!.data!.foto!.isNotEmpty)
                        // AspectRatio(
                        //   aspectRatio: 16 / 9, // Menjaga rasio asli gambar
                        //   child: ClipOval(
                        //     child: Image.network(
                        //       width: 120,
                        //       data.data!.foto!,
                        //       fit: BoxFit.cover, // Mengisi area secara proporsional
                        //     ),
                        //   ),
                        // ),
                        Center(
                          child: AspectRatio(
                            aspectRatio: 487 / 221,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: hijauLight2, width: 3),
                                image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  alignment: FractionalOffset.topCenter,
                                  image: NetworkImage(data.data!.foto!),
                                ),
                              ),
                              // child: ClipRRect(
                              //   child: Image.network(data.data!.foto!, fit: BoxFit.cover, )),
                            ),
                          ),
                        ),
                      if (data.data!.foto!.isEmpty && data.data!.jenisKelamin != "L")
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset("assets/images/avatar.png"),
                          ),
                        ),
                     if (data.data!.foto!.isEmpty && data.data!.jenisKelamin == "L")
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset("assets/images/male.png"),
                          ),
                        ),
                      const SizedBox(height: 28),
                      const AutoSizeText("Informasi Pribadi", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 18)),
                      const SizedBox(height: 20),
                      const AutoSizeText("Alamat Email", maxLines: 1, style: TextStyle(fontFamily: 'MontserratRegular', fontSize: 14)),
                      const SizedBox(height: 12),
                      CustomField(readOnly: true, initialValue: data.data!.users!.email),
                      const SizedBox(height: 24),
                      const AutoSizeText("Username", maxLines: 1, style: TextStyle(fontFamily: 'MontserratRegular', fontSize: 14)),
                      const SizedBox(height: 12),
                      CustomField(readOnly: true, initialValue: data.data!.nama),
                      const SizedBox(height: 24),
                      const AutoSizeText("Nomor Ponsel", maxLines: 1, style: TextStyle(fontFamily: 'MontserratRegular', fontSize: 14)),
                      const SizedBox(height: 12),
                      CustomField(readOnly: true, initialValue: data.data!.hp),
                      const SizedBox(height: 24),
                      const AutoSizeText("Jenis Kelamin", maxLines: 1, style: TextStyle(fontFamily: 'MontserratRegular', fontSize: 14)),
                      const SizedBox(height: 12),
                      if (data.data!.jenisKelamin == "L")
                        CustomField(readOnly: true, initialValue: "Laki-laki", suffixIcon: Icon(Icons.male, color: Colors.blue[200])),
                      if (data.data!.jenisKelamin != "L")
                        CustomField(readOnly: true, initialValue: "Perempuan", suffixIcon: Icon(Icons.female, color: Colors.pink[200])),
                      const SizedBox(height: 24),
                      const AutoSizeText("Tanggal Lahir", maxLines: 1, style: TextStyle(fontFamily: 'MontserratRegular', fontSize: 14)),
                      const SizedBox(height: 12),
                      CustomField(readOnly: true, initialValue: data.data!.tglLahir),
                      // const SizedBox(height: 24),
                      // CustomButton(
                      //   onTap: () {
                      //     cekcv(data.data!.id);
                      //   },
                      //   backgroundColor: hijauLight,
                      //   text: "CV SAYA",
                      //   textStyle: const TextStyle(color: whiteCustom, fontFamily: 'JakartaSansSemiBold', fontSize: 18),
                      // ),
                      const SizedBox(height: 30),
                      CustomButton(
                        onTap: (){
                          Navigator.pushNamed(context, changePasswordScreen, arguments: {"email": data.data!.users!.email});
                        },
                        backgroundColor: hijauLight2,
                        text: "Ganti Password",
                        textStyle: const TextStyle(color: whiteCustom, fontFamily: 'JakartaSansSemiBold', fontSize: 18),
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
                        onTap: logout,
                        backgroundColor: merah,
                        text: "Keluar Akun",
                        textStyle: const TextStyle(color: whiteCustom, fontFamily: 'JakartaSansSemiBold', fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
