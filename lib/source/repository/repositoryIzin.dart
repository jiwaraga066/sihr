import 'package:sihr/source/env/internetCheck.dart';
import 'package:sihr/source/network/Izin/apiIzin.dart';
import 'package:sihr/source/network/network.dart';
import 'package:sihr/source/widget/customDialog.dart';

class IzinRepository {
  Future jenisizin(context) async {
    if (await internetChecker()) {
      var json = await network(url: Apiizin.jenisIzin(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future createIzin(body, context) async {
    if (await internetChecker()) {
      var json = await network(url: Apiizin.createIzin(), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getIzin(context) async {
    if (await internetChecker()) {
      var json = await network(url: Apiizin.getIzin(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getIzinKepalaBagian(context, idKepalaBagian) async {
    if (await internetChecker()) {
      var json = await network(url: Apiizin.getIzinKepalaBagian(idKepalaBagian), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
