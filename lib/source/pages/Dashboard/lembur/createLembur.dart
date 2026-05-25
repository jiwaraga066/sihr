part of '../../index.dart';

class CreateLemburScreen extends StatefulWidget {
  const CreateLemburScreen({super.key});

  @override
  State<CreateLemburScreen> createState() => _CreateLemburScreenState();
}

class _CreateLemburScreenState extends State<CreateLemburScreen> {
  TextEditingController controllerTanggal = TextEditingController();
  TextEditingController controllerJamMulai = TextEditingController();
  TextEditingController controllerJamSelesai = TextEditingController();
  TextEditingController controllerKeterangan = TextEditingController();
  final formkey = GlobalKey<FormState>();

  var valueKategori, valuejenis;

  List kategoriLembur = [
    {"value": "on call", "name": "On Call"},
    {"value": "lembur", "name": "Lembur"},
  ];
  List jenisLembur = [
    {"value": "operasi", "name": "Operasi"},
    {"value": "reguler", "name": "Reguler"},
  ];

  void pilihJamMulai() {
    selectTime(context).then((value) {
      if (value != null) {
        TimeOfDay result = value;
        print(formatTimes(result));
        setState(() {
          controllerJamMulai.text = formatTimes(result);
        });
      }
    });
  }

  void pilihJamSelesai() {
    selectTime(context).then((value) {
      if (value != null) {
        TimeOfDay result = value;
        print(formatTimes(result));
        setState(() {
          controllerJamSelesai.text = formatTimes(result);
        });
      }
    });
  }

  void submit() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<CreateLemburCubit>(context)
          .createLembur(controllerTanggal.text, controllerJamMulai.text, controllerJamSelesai.text, controllerKeterangan.text,  valuejenis,valueKategori, context);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Surat Izin Lembur", style: TextStyle(fontFamily: 'JakartaSansMedium')),
      ),
      body: BlocListener<CreateLemburCubit, CreateLemburState>(
        listener: (context, state) {
          if (state is CreateLemburLoading) {
            MyDialog.dialogLoading(context);
          }
          if (state is CreateLemburFailed) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 403) {
              MyDialog.dialogAlert(context, "This user does not have access.");
            } else {
              MyDialog.dialogAlert2(context, data['errors'].toString(), onPressedOk: () {
                Navigator.of(context).pop();
                BlocProvider.of<GetLemburCubit>(context).getLembur(context);
              });
            }
          }
          if (state is CreateLemburLoaded) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            MyDialog.dialogSuccess(context, 'Successfully', onPressedOk: () {
              Navigator.of(context).pop();
              BlocProvider.of<GetLemburCubit>(context).getLembur(context);
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
                  const AutoSizeText("Pilih Jam Mulai", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomField(
                      readOnly: true,
                      onTap: pilihJamMulai,
                      controller: controllerJamMulai,
                      suffixIcon: const Icon(FontAwesomeIcons.clock),
                      textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14),
                      messageError: "Kolom tidak boleh kosong"),
                  const SizedBox(height: 20),
                  const AutoSizeText("Pilih Jam Selesai", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomField(
                      readOnly: true,
                      onTap: pilihJamSelesai,
                      controller: controllerJamSelesai,
                      suffixIcon: const Icon(FontAwesomeIcons.clock),
                      textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14),
                      messageError: "Kolom tidak boleh kosong"),
                  const SizedBox(height: 20),
                  const AutoSizeText("Pilih Jenis Lembur", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  DropdownButtonFormField(
                    hint: const Text("Jenis Lembur"),
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
                    value: valuejenis,
                    items: jenisLembur.map((e) {
                      return DropdownMenuItem(
                        value: e['value'],
                        child: Text(e['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        valuejenis = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'Please select an option';
                      }
                      return null; // If validation is passed
                    },
                  ),
                  const SizedBox(height: 20),
                  const AutoSizeText("Pilih Kategori Lembur", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  DropdownButtonFormField(
                    hint: const Text("Kategori Lembur"),
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
                    value: valueKategori,
                    items: kategoriLembur.map((e) {
                      return DropdownMenuItem(
                        value: e['value'],
                        child: Text(e['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        valueKategori = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'Please select an option';
                      }
                      return null; // If validation is passed
                    },
                  ),
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
