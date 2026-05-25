part of '../../index.dart';

class AddResumePelatihanScreen extends StatefulWidget {
  const AddResumePelatihanScreen({super.key});

  @override
  State<AddResumePelatihanScreen> createState() => _AddResumePelatihanScreenState();
}

class _AddResumePelatihanScreenState extends State<AddResumePelatihanScreen> {
  final TextEditingController controllerResume = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void submit() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<AbsenPelatihanCubit>(context).updatePartisipasi(context, controllerResume.text);
    }
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
        title: const Text("Resume Pelatihan", style: TextStyle(color: Colors.white)),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  const AutoSizeText("Resume", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomField(
                    readOnly: false,
                    controller: controllerResume,
                    maxline: 6,
                    textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14),
                    messageError: "Kolom harus di isi",
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
