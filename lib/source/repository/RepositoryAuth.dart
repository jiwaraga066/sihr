import 'package:sihr/source/env/internetCheck.dart';
import 'package:sihr/source/network/User/apiUser.dart';
import 'package:sihr/source/network/network.dart';
import 'package:sihr/source/widget/customDialog.dart';

class AuhtRepository {
  Future login(body, context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiUser.login(), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future session(context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiUser.session(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future changePassword(context, body, idUser) async {
    if (await internetChecker()) {
      var json = await network(url: ApiUser.changePassword(idUser), method: "PUT", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
