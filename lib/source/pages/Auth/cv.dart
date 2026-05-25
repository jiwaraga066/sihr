part of '../index.dart';

class CVScreen extends StatefulWidget {
  const CVScreen({super.key});

  @override
  State<CVScreen> createState() => _CVScreenState();
}

class _CVScreenState extends State<CVScreen> {
  var loadingPercentage = 0;
  WebViewController? controller = WebViewController();
  var idPegawai, token;
  void getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    print("token: $token");
    idPegawai = pref.getString("id_pegawai");
    print("pegawai: $idPegawai");
  }

  void cekcv() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    token = pref.getString("token");
        print("https://hris.rsuumc.com/pegawai/$idPegawai?token=$token");
    Future.delayed(const Duration(seconds: 2), () async {
      if (!await launchUrl(Uri.parse("https://hris.rsuumc.com/pegawai/$idPegawai?token=$token"))) {
        throw Exception('Could not launch "https://hris.rsuumc.com/pegawai/$idPegawai"');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getSession();
    cekcv();
    // Future.delayed(const Duration(seconds: 2), () {
    //   controller = WebViewController()
    //     ..setNavigationDelegate(NavigationDelegate(
    //       onPageStarted: (url) {
    //         setState(() {
    //           loadingPercentage = 0;
    //         });
    //       },
    //       onProgress: (progress) {
    //         setState(() {
    //           loadingPercentage = progress;
    //         });
    //       },
    //       onPageFinished: (url) {
    //         setState(() {
    //           loadingPercentage = 100;
    //         });
    //       },
    //     ))
    //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //     ..loadRequest(Uri.parse("https://hris.rsuumc.com/pegawai/$idPegawai?token=$token"));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CV Saya"),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            if (controller != null) WebViewWidget(controller: controller!),
            if (loadingPercentage > 0)
              LinearProgressIndicator(
                value: loadingPercentage / 100,
              )
          ],
        ),
      ),
    );
  }
}
