import 'package:sihr/source/env/internetCheck.dart';
import 'package:sihr/source/network/Absensi/apiAbseni.dart';
import 'package:sihr/source/network/network.dart';
import 'package:sihr/source/widget/customDialog.dart';

class AbsensiRepository {
  Future postAbsensi(body, context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiAbsensi.postAbsensi(), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future updateAbsensi(idAbsensi, body, context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiAbsensi.updateAbsensi(idAbsensi), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getAbsensi(context, tglAwal, tglAkhir) async {
    if (await internetChecker()) {
      var json = await network(url: ApiAbsensi.getAbsensiDate(tglAwal, tglAkhir), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getSisaAbsensi(context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiAbsensi.getSisaAbsensi(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
  Future getJenisAbsensi(context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiAbsensi.getJenisAbsensi(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
