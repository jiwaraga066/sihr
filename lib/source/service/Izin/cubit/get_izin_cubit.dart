import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/model/Modelizin/modelIzin.dart';
import 'package:sihr/source/repository/repositoryIzin.dart';

part 'get_izin_state.dart';

class GetIzinCubit extends Cubit<GetIzinState> {
  final IzinRepository? repository;
  GetIzinCubit({this.repository}) : super(GetIzinInitial());

  void getizin(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? idPegawai = pref.getString("id_pegawai");
    emit(GetIzinLoading());
    repository!.getIzin(context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print(json);
      if (statusCode == 200 || statusCode == 201) {
        emit(GetIzinLoaded(statusCode: statusCode, model: modelIzinFromJson(jsonEncode(json)), idPegawai: int.parse(idPegawai!)));
      } else {
        emit(GetIzinFailed(statusCode: statusCode, json: json));
      }
    });
  }
  void getizinKepalaBagian(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? idPegawai = pref.getString("id_pegawai");
    String? idKepalaBagian = pref.getString("idKepalaBagian");
    emit(GetIzinLoading());
    repository!.getIzinKepalaBagian(context, idPegawai).then((value) {
      var json = value.data;
  var statusCode = value.statusCode;
      print(json);
      if (statusCode == 200 || statusCode == 201) {
        emit(GetIzinLoaded(statusCode: statusCode, model: modelIzinFromJson(jsonEncode(json)), idPegawai: int.parse(idPegawai!)));
      } else {
        emit(GetIzinFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
