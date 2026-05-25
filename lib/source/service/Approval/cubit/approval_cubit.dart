import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/env/env.dart';
import 'package:sihr/source/repository/RepositoryApproval.dart';

part 'approval_state.dart';

class ApprovalCubit extends Cubit<ApprovalState> {
  final RepostoryApproval? repository;
  ApprovalCubit({this.repository}) : super(ApprovalInitial());

  void approval(context, status, feedback) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (menuApproval == "cuti") {
      var body = {"status": "$status", "feedback": "$feedback"};
      print(body);
      emit(ApprovalLoading());
      repository!.postApprovalCuti(idApproval, body, context).then((value) {
        var json = value.data;
        var statusCode = value.statusCode;
        print(json);
        if (statusCode == 200 || statusCode == 200) {
          emit(ApprovalLoaded(statusCode: statusCode, json: json));
        } else {
          emit(ApprovalFailed(statusCode: statusCode, json: json));
        }
      });
    } else if (menuApproval == "lembur") {
      var body = {"status": "$status", "feedback": "$feedback"};
      print(body);
      emit(ApprovalLoading());
      repository!.postApprovalLembur(idApproval, body, context).then((value) {
        var json = value.data;
        var statusCode = value.statusCode;
        print(json);
        if (statusCode == 200 || statusCode == 200) {
          emit(ApprovalLoaded(statusCode: statusCode, json: json));
        } else {
          emit(ApprovalFailed(statusCode: statusCode, json: json));
        }
      });
    } else if (menuApproval == "izin") {
      var body = {"status": "$status", "feedback": "$feedback"};
      print(body);
      emit(ApprovalLoading());
      repository!.postApprovalIzin(idApproval, body, context).then((value) {
        var json = value.data;
        var statusCode = value.statusCode;
        print(json);
        if (statusCode == 200 || statusCode == 200) {
          emit(ApprovalLoaded(statusCode: statusCode, json: json));
        } else {
          emit(ApprovalFailed(statusCode: statusCode, json: json));
        }
      });
    }
  }
}
