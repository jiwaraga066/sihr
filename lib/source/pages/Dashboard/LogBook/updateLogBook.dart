part of '../../index.dart';

class UpdateLogBookScreen extends StatefulWidget {
  const UpdateLogBookScreen({super.key});

  @override
  State<UpdateLogBookScreen> createState() => _UpdateLogBookScreenState();
}

class _UpdateLogBookScreenState extends State<UpdateLogBookScreen> {
  TextEditingController controllerTanggal = TextEditingController();
  TextEditingController controllerNamaLog = TextEditingController();
  TextEditingController controllerKeterangan = TextEditingController();
  TextEditingController controllerFile = TextEditingController();
  var file;
  final formkey = GlobalKey<FormState>();

  void pickdate() {
    pickDate(context).then((value) {
      if (value != null) {
        var date = DateFormat('yyyy-MM-dd').format(value);
        setState(() {
          controllerTanggal.text = date;
        });
      }
    });
  }

  void pickFile() async {
    selectPDF().then((value) {
      print("FILE: $value");
      setState(() {
        file = value;
        controllerFile.text = value.path;
      });
    });
  }

  void submit() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<UpdateLogBookCubit>(context).updateLogBook(context, controllerNamaLog.text, controllerTanggal.text, controllerKeterangan.text, file);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      controllerTanggal = TextEditingController(text: tanggalLogbook);
      controllerNamaLog = TextEditingController(text: namalog);
      controllerKeterangan = TextEditingController(text: keteranganlog);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Log Book", style: TextStyle(fontFamily: 'JakartaSansMedium')),
      ),
      body: BlocListener<UpdateLogBookCubit, UpdateLogBookState>(
        listener: (context, state) {
          if (state is UpdateLogBookLoading) {
            MyDialog.dialogLoading(context);
          }
          if (state is UpdateLogBookFailed) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 403) {
              MyDialog.dialogAlert2(context, "This user does not have access.", onPressedOk: () {
                Navigator.of(context).pop();
                BlocProvider.of<GetLogBookCubit>(context).getLogBook(context);
              });
            } else {
              MyDialog.dialogAlert(context, data['errors'].toString());
            }
          }
          if (state is UpdateLogBookLoaded) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            MyDialog.dialogSuccess(context, data['message'], onPressedOk: () {
              Navigator.of(context).pop();
              BlocProvider.of<GetLogBookCubit>(context).getLogBook(context);
            });
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AutoSizeText("Tanggal Pembuatan", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                    const SizedBox(height: 12),
                    CustomField(
                        readOnly: true,
                        controller: controllerTanggal,
                        onTap: pickdate,
                        suffixIcon: const Icon(FontAwesomeIcons.calendar),
                        textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14)),
                    const SizedBox(height: 20),
                    const AutoSizeText("Nama Log Book", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                    const SizedBox(height: 12),
                    CustomField(
                        readOnly: false,
                        controller: controllerNamaLog,
                        suffixIcon: const Icon(FontAwesomeIcons.book),
                        textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14)),
                    const SizedBox(height: 20),
                    const AutoSizeText("File Upload", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                    const SizedBox(height: 12),
                    CustomField(
                        readOnly: true,
                        controller: controllerFile,
                        onTap: pickFile,
                        suffixIcon: const Icon(FontAwesomeIcons.file),
                        textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14)),
                    const SizedBox(height: 20),
                    const AutoSizeText("Keterangan", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                    const SizedBox(height: 12),
                    CustomField(
                        controller: controllerKeterangan,
                        maxline: 3,
                        textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14),
                        messageError: "Kolom tidak boleh kosong"),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: CustomButton2(
                        onTap: submit,
                        text: "Submit",
                        backgroundColor: hijauTeal1,
                        textStyle: const TextStyle(color: whiteCustom, fontSize: 20, fontFamily: 'JakartaSansSemiBold'),
                        roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
