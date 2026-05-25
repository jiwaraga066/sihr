import 'package:sihr/source/env/internetCheck.dart';
import 'package:sihr/source/network/Pegawai/apiPegawai.dart';
import 'package:sihr/source/network/network.dart';
import 'package:sihr/source/widget/customDialog.dart';

class PegawaiRepository {
  Future getPegawai(context, id) async {
    if (await internetChecker()) {
      var json = await network(url: ApiPegawai.getPegawai(id), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
