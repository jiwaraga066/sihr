part of '../../index.dart';

class CreateCutiScreen extends StatefulWidget {
  const CreateCutiScreen({super.key});

  @override
  State<CreateCutiScreen> createState() => _CreateCutiScreenState();
}

class _CreateCutiScreenState extends State<CreateCutiScreen> {
  TextEditingController controllerTanggal = TextEditingController();
  TextEditingController controllerTglMulai = TextEditingController();
  TextEditingController controllerTglSelesai = TextEditingController();
  TextEditingController controllerKeterangan = TextEditingController();
  var valueCuti;
  final formkey = GlobalKey<FormState>();

  DateTime? startDate;
  DateTime? endDate;

  // Format untuk menampilkan tanggal
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  void pilihtglMulai() async {
    final DateTime today = DateTime.now();
    DateTime? initialDate;
    setState(() {
      if (valueCuti == 13) {
        initialDate = today; // 1 minggu dari sekarang
      } else {
        initialDate = today.add(const Duration(days: 7)); // 1 minggu dari sekarang
      }
    });
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate!,
      firstDate: initialDate!,
      lastDate: today.add(const Duration(days: 365)), // Maksimal 1 tahun ke depan
    );

    if (pickedDate != null) {
      setState(() {
        startDate = pickedDate;
        endDate = null;
        controllerTglMulai.text = pickedDate.toString().split(' ')[0];
      });
    }
  }

  void pilihtglSelesai() async {
    setState(() {});
    if (startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih tanggal awal terlebih dahulu!')),
      );
      return;
    }
    print(valueCuti);
    final DateTime initialDate = startDate!; // 1 hari setelah startDate
    DateTime? lastAllowedDate;
    if (valueCuti != 3) {
      lastAllowedDate = startDate!.add(const Duration(days: 7));
    } else {
      lastAllowedDate = DateTime(2100, 12, 31);
    }
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: lastAllowedDate,
    );

    if (pickedDate != null) {
      setState(() {
        endDate = pickedDate;
        controllerTglSelesai.text = pickedDate.toString().split(' ')[0];
      });
    }
  }

  void submit() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<CreateCutiCubit>(context)
          .createCuti(valueCuti, controllerTglMulai.text, controllerTglSelesai.text, controllerKeterangan.text, tanggal, context);
    }
  }

  @override
  void initState() {
    super.initState();
    controllerTanggal = TextEditingController(text: tanggal);
    BlocProvider.of<JenisCutiCubit>(context).getjeniscuti(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Surat Pengajuan Cuti", style: TextStyle(fontFamily: 'JakartaSansMedium')),
      ),
      body: BlocListener<CreateCutiCubit, CreateCutiState>(
        listener: (context, state) {
          if (state is CreateCutiLoading) {
            MyDialog.dialogLoading(context);
          }
          if (state is CreateCutiFailed) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 403) {
              MyDialog.dialogAlert2(context, "This user does not have access.", onPressedOk: () {
                Navigator.of(context).pop();
                BlocProvider.of<GetCutiCubit>(context).getCuti(context);
              });
            } else {
              MyDialog.dialogAlert2(context, data['errors'].toString());
            }
          }
          if (state is CreateCutiLoaded) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            MyDialog.dialogSuccess(context, "Successfully !", onPressedOk: () {
              Navigator.of(context).pop();
              BlocProvider.of<GetCutiCubit>(context).getCuti(context);
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
                  // const AutoSizeText("Tanggal Pengajuan", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  // const SizedBox(height: 12),
                  // CustomField(
                  //     readOnly: true,
                  //     controller: controllerTanggal,
                  //     onTap: pickdate,
                  //     suffixIcon: const Icon(FontAwesomeIcons.calendar),
                  //     textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14)),
                  // const SizedBox(height: 20),
                  const AutoSizeText("Pilih kategori Cuti", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  BlocBuilder<JenisCutiCubit, JenisCutiState>(
                    builder: (context, state) {
                      if (state is JenisCutiLoading) {
                        return CustomField(readOnly: true, hintText: "Kategori ", textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14));
                      }
                      if (state is JenisCutiLoaded == false) {
                        return CustomField(
                            readOnly: true, controller: controllerTanggal, textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14));
                      }
                      var data = (state as JenisCutiLoaded).model;
                      return Container(
                        child: DropdownButtonFormField(
                          hint: const Text("Kategori Cuti"),
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
                          value: valueCuti,
                          items: data!.data!.map((e) {
                            return DropdownMenuItem(
                              value: e.id,
                              child: Text(e.namaCuti!),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              valueCuti = value;
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
                  const AutoSizeText("Pilih Tanggal Mulai", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomField(
                      readOnly: true,
                      onTap: pilihtglMulai,
                      controller: controllerTglMulai,
                      suffixIcon: const Icon(FontAwesomeIcons.calendar),
                      textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14),
                      messageError: "Kolom tidak boleh kosong"),
                  const SizedBox(height: 20),
                  const AutoSizeText("Pilih Tanggal Selesai", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomField(
                      readOnly: true,
                      onTap: pilihtglSelesai,
                      controller: controllerTglSelesai,
                      suffixIcon: const Icon(FontAwesomeIcons.calendar),
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
