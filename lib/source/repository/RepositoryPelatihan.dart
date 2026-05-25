import 'package:sihr/source/env/internetCheck.dart';
import 'package:sihr/source/network/Pelatihan/apiPelatihan.dart';
import 'package:sihr/source/network/network.dart';
import 'package:sihr/source/widget/customDialog.dart';

class PelatihanRepository {
  Future jenisPelatihan(context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiPelatihan.jenisPelatihan(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future kategoriPelatihan(context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiPelatihan.kategoriPelatihan(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getPelatihan(context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiPelatihan.pelatihan(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future postPartisipasiPelatihan(context, body) async {
    if (await internetChecker()) {
      var json = await network(url: ApiPelatihan.postpartisipasipelatihan(), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future updatePartisipasiPelatihan(context, id, body) async {
    if (await internetChecker()) {
      var json = await network(url: ApiPelatihan.updatepartisipasipelatihan(id), method: "PUT", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
