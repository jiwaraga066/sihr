import 'package:sihr/source/env/internetCheck.dart';
import 'package:sihr/source/network/Approval/apiApproval.dart';
import 'package:sihr/source/network/network.dart';
import 'package:sihr/source/widget/customDialog.dart';

class RepostoryApproval {
  Future postApprovalCuti(id, body, context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiApproval.approvalCuti(id), method: "PUT", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
  Future postApprovalLembur(id, body, context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiApproval.approvalLembur(id), method: "PUT", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
  Future postApprovalIzin(id, body, context) async {
    if (await internetChecker()) {
      var json = await network(url: ApiApproval.approvalIzin(id), method: "PUT", body: body, context: context);
      return json;
    } else {
      MyDialog.dialogAlert(context, "Maaf, Ada Kesalahan Jaringan !");
    }
  }
}
