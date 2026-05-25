part of '../../index.dart';

class CreateIzinScreen extends StatefulWidget {
  const CreateIzinScreen({super.key});

  @override
  State<CreateIzinScreen> createState() => _CreateIzinScreenState();
}

class _CreateIzinScreenState extends State<CreateIzinScreen> {
  TextEditingController controllerTanggal = TextEditingController();
  TextEditingController controllerAlasan = TextEditingController();
  TextEditingController controllerKeterangan = TextEditingController();
  final formkey = GlobalKey<FormState>();
  var valueIzin;

  void submit() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<CreateIzinCubit>(context).createIzin(controllerTanggal.text,  controllerAlasan.text, controllerKeterangan.text, valueIzin, context);
    }
  }

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

  @override
  void initState() {
    super.initState();
    controllerTanggal = TextEditingController(text: tanggal);
    BlocProvider.of<JenisIzinCubit>(context).getjenisIzin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengajuan izin", style: TextStyle(fontFamily: 'JakartaSansMedium')),
      ),
      body: BlocListener<CreateIzinCubit, CreateIzinState>(
        listener: (context, state) {
          if (state is CreateIzinLoading) {
            MyDialog.dialogLoading(context);
          }
          if (state is CreateIzinFailed) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 403) {
              MyDialog.dialogAlert2(context, "This user does not have access.", onPressedOk: () {
                Navigator.of(context).pop();
                BlocProvider.of<GetIzinCubit>(context).getizin(context);
              });
            } else {
              MyDialog.dialogAlert(context, data['errors'].toString());
            }
          }
          if (state is CreateIzinLoaded) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            MyDialog.dialogSuccess(context, 'Successfully', onPressedOk: () {
              Navigator.of(context).pop();
              BlocProvider.of<GetIzinCubit>(context).getizin(context);
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
                  BlocBuilder<JenisIzinCubit, JenisIzinState>(
                    builder: (context, state) {
                      if (state is JenisIzinLoading) {
                        return CustomField(readOnly: true, hintText: "Kategori ", textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14));
                      }
                      if (state is JenisIzinLoaded == false) {
                        return CustomField(
                            readOnly: true, controller: controllerTanggal, textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14));
                      }
                      var data = (state as JenisIzinLoaded).model;
                      return Container(
                        child: DropdownButtonFormField(
                          hint: const Text("Kategori Izin"),
                          borderRadius: BorderRadius.circular(10),
                          isExpanded: true,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: merah, strokeAlign: 20),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.8), width: 2),
                            ),
                          ),
                          value: valueIzin,
                          items: data!.data!.map((e) {
                            return DropdownMenuItem(
                              value: e.id,
                              child: Text(e.namaIzin!),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              valueIzin = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return 'Please select an option';
                            }
                            return null; // If validation is passed
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const AutoSizeText("Alasan", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomField(
                      controller: controllerAlasan,
                      textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14),
                      messageError: "Kolom tidak boleh kosong"),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
