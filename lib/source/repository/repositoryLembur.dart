import 'package:sihr/source/env/internetCheck.dart';
import 'package:sihr/source/network/Lembur/apiLembur.dart';
import 'package:sihr/source/network/network.dart';
import 'package:sihr/source/widget/customDialog.dart';

class LemburRepository {
  Future createLembur(body, context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiLembur.createLembur(), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getLembur(context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiLembur.getLembur(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getLemburKepalaBagian(context, idKepalaBagian) async {
    if (await internetChecker()) {
      var json = await network(url: ApiLembur.getLemburKepalaBagian(idKepalaBagian), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
