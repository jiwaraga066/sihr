import 'package:sihr/source/env/internetCheck.dart';
import 'package:sihr/source/network/Cuti/apiCuti.dart';
import 'package:sihr/source/network/network.dart';
import 'package:sihr/source/widget/customDialog.dart';

class CutiRepository {
  Future jeniscuti(context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiCuti.jeniscuti(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getCuti(context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiCuti.getCuti(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getCutiKepalaBagian(context, idKepalaBagian) async {
    if (await internetChecker()) {
      var json = await network(url: ApiCuti.getCutiKepalaBagian(idKepalaBagian), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future createCuti(body, context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiCuti.createCuti(), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
