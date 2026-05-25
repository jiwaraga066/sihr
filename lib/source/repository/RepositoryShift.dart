import 'package:sihr/source/env/internetCheck.dart';
import 'package:sihr/source/network/Shift/apiShift.dart';
import 'package:sihr/source/network/network.dart';
import 'package:sihr/source/widget/customDialog.dart';

class ShiftRepository {
  Future getShift(context, id) async {
    if (await internetChecker()) {
      var json = await network(url: ApiShift.getShift(id), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
