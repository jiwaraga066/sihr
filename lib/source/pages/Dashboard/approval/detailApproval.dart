part of '../../index.dart';

class ApprovalDetailScreen extends StatefulWidget {
  const ApprovalDetailScreen({super.key});

  @override
  State<ApprovalDetailScreen> createState() => _ApprovalDetailScreenState();
}

class _ApprovalDetailScreenState extends State<ApprovalDetailScreen> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerTanggal = TextEditingController();
  TextEditingController controllerKeterangan = TextEditingController();
  TextEditingController controllerFeedback = TextEditingController();
  var valueStatus;
  final formkey = GlobalKey<FormState>();
  List listStatus = [
    // {"value": 0, "name": "Proses"},
    {"value": 1, "name": "ACC KEPALA"},
    {"value": 2, "name": "Reject"},
    // {"value": 3, "name": "ACC HRD"},
  ];
  void submit() {
    if (formkey.currentState!.validate()) {
      print(menuApproval);
      print(idApproval);
      if (valueStatus == 2) {
        BlocProvider.of<ApprovalCubit>(context).approval(context, valueStatus, controllerFeedback.text);
      } else {
        BlocProvider.of<ApprovalCubit>(context).approval(context, valueStatus, "-");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      controllerNama = TextEditingController(text: namaApproval);
      controllerTanggal = TextEditingController(text: tanggalApproval);
      controllerKeterangan = TextEditingController(text: keteranganApproval);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Approval', style: TextStyle(fontFamily: 'JakartaSansMedium')),
      ),
      body: BlocListener<ApprovalCubit, ApprovalState>(
        listener: (context, state) {
          if (state is ApprovalLoading) {
            MyDialog.dialogLoading(context);
          }
          if (state is ApprovalFailed) {
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
          if (state is ApprovalLoaded) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            MyDialog.dialogSuccess(context, "Successfully !", onPressedOk: () {
              Navigator.of(context).pop();
              if (menuApproval == "cuti") {
                BlocProvider.of<GetCutiCubit>(context).getCutiKepalaBagian(context);
              } else if (menuApproval == "izin") {
                BlocProvider.of<GetIzinCubit>(context).getizinKepalaBagian(context);
              } else if (menuApproval == "lembur") {
                BlocProvider.of<GetLemburCubit>(context).getLemburKepalaBagian(context);
              }
            });
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AutoSizeText("Nama Pegawai", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomField(
                      readOnly: true,
                      controller: controllerNama,
                      preffixIcon: const Icon(FontAwesomeIcons.user),
                      textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14),
                      messageError: "Kolom tidak boleh kosong"),
                  const SizedBox(height: 20),
                  const AutoSizeText("Tanggal", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomField(
                      readOnly: true,
                      controller: controllerTanggal,
                      preffixIcon: const Icon(FontAwesomeIcons.calendar),
                      textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14),
                      messageError: "Kolom tidak boleh kosong"),
                  const SizedBox(height: 20),
                  const AutoSizeText("Keterangan", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomField(
                      readOnly: true,
                      controller: controllerKeterangan,
                      textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14),
                      maxline: 4,
                      messageError: "Kolom tidak boleh kosong"),
                  const SizedBox(height: 20),
                  const AutoSizeText("Status", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  Container(
                    child: DropdownButtonFormField(
                      hint: const Text("Kategori Status"),
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
                      value: valueStatus,
                      items: listStatus.map((e) {
                        return DropdownMenuItem(
                          value: e['value'],
                          child: Text(e['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          valueStatus = value;
                          print(valueStatus);
                          if (valueStatus == 1) {
                            controllerFeedback.clear();
                          }
                        });
                      },
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return 'Please select an category';
                        }
                        return null; // If validation is passed
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (valueStatus == 2)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText("Feedback", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                        const SizedBox(height: 12),
                        CustomField(
                            readOnly: false,
                            controller: controllerFeedback,
                            textstyle: const TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 14),
                            maxline: 4,
                            messageError: "Kolom tidak boleh kosong"),
                      ],
                    ),
                  const SizedBox(height: 20),
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
