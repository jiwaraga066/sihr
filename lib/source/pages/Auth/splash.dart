part of '../index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).checkSession(context);
    // BlocProvider.of<AuthCubit>(context).session(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://api.hris.rsuumc.com/storage/assets/img/logo_perusahaan/logo_e629cec4f652fd5211e5f7eeb4324a70.png",
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 48.0),
                  SizedBox(height: 8.0),
                  Text('Failed to load image', style: TextStyle(color: Colors.red)),
                ],
              );
            }, height: 180),
            const SizedBox(height: 15),
            // const CircularProgressIndicator(color: Colors.blue)
          ],
        ),
      ),
    );
  }
}
