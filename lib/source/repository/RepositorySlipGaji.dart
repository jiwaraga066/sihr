import 'package:sihr/source/env/internetCheck.dart';
import 'package:sihr/source/network/SlipGaji/apiSlipGaji.dart';
import 'package:sihr/source/network/network.dart';
import 'package:sihr/source/widget/customDialog.dart';

class RepositorySlipGaji {
  Future getSlip(bulan, tahun, idPegawai, context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiSlipGaji.getSlip(bulan, tahun, idPegawai), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getPayroll(bulan, tahun, idPegawai, context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiSlipGaji.getPayroll(bulan, tahun, idPegawai), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
