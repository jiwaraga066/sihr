import 'package:sihr/source/env/internetCheck.dart';
import 'package:sihr/source/network/LogBook/apiLogBook.dart';
import 'package:sihr/source/network/network.dart';
import 'package:sihr/source/widget/customDialog.dart';

class RepositoryLogBook {
  Future masterLogBook(context, idjabatan) async {
    if (await internetChecker()) {
      var json = await network(url: ApiLogBook.masterLogBook(idjabatan), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future getLogBook(context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiLogBook.getLogBook(), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future createLogBook(context, body) async {
    if (await internetChecker()) {
      var json = await network(url: ApiLogBook.createLogBook(), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future updateLogBook(context, body, id) async {
    if (await internetChecker()) {
      var json = await network(url: ApiLogBook.updateLogBook(id), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  // perawat
  Future getLogBookPerawat(context, id) async {
    if (await internetChecker()) {
      var json = await network(url: ApiLogBook.getLogBookPerawat(id), method: "GET", body: null, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future createLogBookPerawat(context, body) async {
    if (await internetChecker()) {
      var json = await network(url: ApiLogBook.createLogBookPerawat(), method: "POST", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }

  Future updateLogBookPerawat(context, body, id) async {
    if (await internetChecker()) {
      var json = await network(url: ApiLogBook.updateLogBookPerawat(id), method: "PUT", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
