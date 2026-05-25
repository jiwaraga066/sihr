part of '../index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final formkey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool rememberme = false;

  void handleRememberme(bool? value) {
    setState(() {
      rememberme = !rememberme;
      print(rememberme);
    });
  }

  void handlePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void login() {
    if (formkey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).login(controllerEmail.text, controllerPassword.text, rememberme, context);
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).checkemailLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthSaveEmail) {
            setState(() {
              controllerEmail = TextEditingController(text: state.email!);
            });
          }
          // if (state is AuthLoaded) {
          //   Navigator.of(context).pop();
          //   var json = state.json;
          //   var statusCode = state.statusCode;
          //   if (statusCode == 200) {
          //         // BlocProvider.of<AuthCubit>(context).session(context);
          //     // MyDialog.dialogSuccess(context, json['message']);
          //     // await Future.delayed(const Duration(seconds: 1));
          //     // Navigator.pushNamedAndRemoveUntil(context, dashboardScreen, (Route<dynamic> route) => false);
          //   } else {
          //     // MyDialog.dialogAlert(context, json['message']);
          //   }
          // }
        },
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            // decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Text("Si - HR", style: TextStyle(color: Colors.indigo, fontFamily: 'JakartaSansMedium', fontSize: 35)),
                const SizedBox(height: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Halo,", style: TextStyle(fontFamily: 'MontserratMedium', fontSize: 35)),
                    SizedBox(height: 2),
                    Text("Selamat Datang", style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 40)),
                  ],
                ),
                const SizedBox(height: 6),
                const AutoSizeText("Silahkan masukan email dan password Anda", style: TextStyle(fontFamily: 'JakartaSansMedium', fontSize: 15), maxLines: 1),
                const SizedBox(height: 40),
                Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Column(
                      children: [
                        CustomField(
                          controller: controllerEmail,
                          keyboardType: TextInputType.emailAddress,
                          preffixIcon: const Icon(Icons.email),
                          hintText: "Masukan email anda",
                          messageError: "Please fill this field",
                        ),
                        const SizedBox(height: 30),
                        CustomField(
                          controller: controllerPassword,
                          hidePassword: hidePassword,
                          maxline: 1,
                          preffixIcon: const Icon(FontAwesomeIcons.lock),
                          suffixIcon:
                              InkWell(onTap: handlePassword, child: hidePassword ? const Icon(FontAwesomeIcons.eyeSlash) : const Icon(FontAwesomeIcons.eye)),
                          hintText: "Masukan password anda",
                          messageError: "Please fill this field",
                        ),
                        Row(
                          children: [
                            Checkbox(
                                tristate: true, // Example with tristate
                                value: rememberme,
                                onChanged: handleRememberme),
                            const Text('Ingat Saya', style: TextStyle(fontSize: 17.0)),
                          ],
                        ),
                        const SizedBox(height: 70),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child: CustomButton2(
                            onTap: login,
                            text: "Masuk",
                            backgroundColor: hijau,
                            textStyle: const TextStyle(color: whiteCustom, fontSize: 20, fontFamily: 'JakartaSansSemiBold'),
                            roundedRectangleBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
