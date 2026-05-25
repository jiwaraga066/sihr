import 'package:permission_handler/permission_handler.dart';

Future<bool> requestStoragePermission() async {
  // Untuk Android 11 ke atas, coba akses MANAGE_EXTERNAL_STORAGE
  if (await Permission.manageExternalStorage.isGranted) {
    return true;
  }
  // Jika belum, minta izin
  var status = await Permission.manageExternalStorage.request();
  if (status.isGranted) {
    return true;
  } else {
    print("Izin penyimpanan ditolak.");
    return false;
  }
}
