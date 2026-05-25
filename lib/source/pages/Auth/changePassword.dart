part of '../index.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPasswordBaru = TextEditingController();
  bool hidePassword = true;
  final formkey = GlobalKey<FormState>();
  void handlePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void changePassword() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<ChangePasswordCubit>(context).changePassword(context, controllerEmail.text, controllerPasswordBaru.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    controllerEmail = TextEditingController(text: data['email'].toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordLoading) {
            MyDialog.dialogLoading(context);
          }
          if (state is ChangePasswordFailed) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 403) {
              MyDialog.dialogAlert(context, "This user does not have access.");
            } else {
              MyDialog.dialogAlert(context, data['errors'].toString());
            }
          }
          if (state is ChangePasswordLoaded) {
            Navigator.of(context).pop();
            var data = state.json;
            var statusCode = state.statusCode;
            MyDialog.dialogSuccess(context, data['message'], onPressedOk: () {
              Navigator.pop(context);
              // BlocProvider.of<GetPegawaiCubit>(context).getPegawai(context);
            });
          }
        },
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AutoSizeText("Email", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomField(
                    controller: controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    preffixIcon: const Icon(Icons.email),
                    hintText: "Masukan email anda",
                    messageError: "Please fill this field",
                    readOnly: true,
                  ),
                  const SizedBox(height: 30),
                  const AutoSizeText("Kata Sandi Baru", maxLines: 1, style: TextStyle(fontFamily: 'JakartaSansSemiBold', fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomField(
                    controller: controllerPasswordBaru,
                    keyboardType: TextInputType.text,
                    hidePassword: hidePassword,
                    maxline: 1,
                     preffixIcon: const Icon(FontAwesomeIcons.lock),
                        suffixIcon:
                              InkWell(onTap: handlePassword, child: hidePassword ? const Icon(FontAwesomeIcons.eyeSlash) : const Icon(FontAwesomeIcons.eye)),
                    hintText: "Masukan kata sandi baru ",
                    messageError: "Please fill this field",
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: CustomButton2(
                      onTap: changePassword,
                      text: "Submit",
                      backgroundColor: hijauLight2,
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
