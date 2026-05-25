import 'package:file_picker/file_picker.dart';

Future selectPDF() async {
  FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
  PlatformFile file = pickedFile!.files.first;
  return file;
}
