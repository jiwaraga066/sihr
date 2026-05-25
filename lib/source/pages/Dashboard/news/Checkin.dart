part of '../../index.dart';

class CheckInNewsScreen extends StatefulWidget {
  const CheckInNewsScreen({super.key});

  @override
  State<CheckInNewsScreen> createState() => _CheckInNewsScreenState();
}

class _CheckInNewsScreenState extends State<CheckInNewsScreen> {
  final TextEditingController controllerResume = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void submit() {
    if (statusAbsenNews == "Resume") {
      if (formkey.currentState!.validate()) {
        BlocProvider.of<UpdatePengumumanPesertaCubit>(context).updateResumePengumumanPeserta(context, idNews, controllerResume.text);
      }
    } else {
      BlocProvider.of<UpdatePengumumanPesertaCubit>(context).updateCheckInPengumumanPeserta(context, idNews, gambar);
    }
  }

  XFile? gambar;
  void pickImage() async {
    selectPhoto(source: ImageSource.camera).then((value) {
      setState(() {
        gambar = value;
        print("gambar: ${gambar!.path}");
      });
    });
  }
@override
void initState() {
  super.initState();
  if (valueResume != null || valueResume.isNotEmpty) {
    setState(() {
      controllerResume.text = valueResume.toString();
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: biru,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Check In News", style: TextStyle(color: Colors.white)),
      ),
      body: BlocListener<UpdatePengumumanPesertaCubit, UpdatePengumumanPesertaState>(
        listener: (context, state) {
          if (state is UpdatePengumumanPesertaLoading) {
            MyDialog.dialogLoading(context);
          }
          if (state is UpdatePengumumanPesertaFailed) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 403) {
              MyDialog.dialogAlert(context, "This user does not have access.");
            } else {
              MyDialog.dialogAlert(context, data['errors'].toString());
            }
          }
          if (state is UpdatePengumumanPesertaLoaded) {
            Navigator.of(context).pop();
            var data = state.json;
            MyDialog.dialogSuccess(context, data['message'], onPressedOk: () {
              Navigator.of(context).pop();
              BlocProvider.of<GetPengumumanPesertaCubit>(context).getPengumumanPeserta(context);
            });
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (statusAbsenNews == "CheckIn")
                  Column(
                    children: [
                      const SizedBox(height: 12),
                      const AutoSizeText("Foto", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: pickImage,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 450,
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black.withOpacity(0.5), width: 1)),
                          child: gambar == null ? const Center(child: Icon(FontAwesomeIcons.image)) : Image.file(File(gambar!.path)),
                        ),
                      ),
                    ],
                  ),
                  if (statusAbsenNews == "Resume")
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      const AutoSizeText("Resume", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                      const SizedBox(height: 12),
                      CustomField(
                        readOnly: false,
                        controller: controllerResume,
                        maxline: 6,
                        textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14),
                        messageError: "Kolom harus di isi",
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: CustomButton2(
                      onTap: submit,
                      text: "SUBMIT",
                      textStyle: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'JakartaSansSemiBold'),
                      backgroundColor: hijauLight2,
                      roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
