import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/repository/RepositoryAuth.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuhtRepository? repository;
  ChangePasswordCubit({this.repository}) : super(ChangePasswordInitial());

  void changePassword(context, email, password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUser = pref.getString("id");
    var idPegawai = pref.getString("id_pegawai");

    var body = {
      "id_pegawai": "$idPegawai",
      "email": "$email",
      "password": "$password",
      "status": "1",
    };

    emit(ChangePasswordLoading());
    repository!.changePassword(context, body, idUser).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print(statusCode);
      print("CHANGE PW: $json");
      if (statusCode == 200 || statusCode == 201) {
        emit(ChangePasswordLoaded(statusCode: statusCode, json: json));
      } else {
        emit(ChangePasswordFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
