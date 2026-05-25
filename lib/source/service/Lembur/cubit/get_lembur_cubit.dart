import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/model/ModelLembur/modelLembur.dart';
import 'package:sihr/source/repository/repositoryLembur.dart';

part 'get_lembur_state.dart';

class GetLemburCubit extends Cubit<GetLemburState> {
  final LemburRepository? repository;
  GetLemburCubit({this.repository}) : super(GetLemburInitial());

  void getLembur(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? idPegawai = pref.getString("id_pegawai");
    emit(GetLemburLoading());
    repository!.getLembur(context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print(json);
      if (statusCode == 200 || statusCode == 201) {
        emit(GetLemburLoaded(statusCode: statusCode, model: modelLemburFromJson(jsonEncode(json)), idPegawai: int.parse(idPegawai!)));
      } else {
        emit(GetLemburFailed(statusCode: statusCode, json: json));
      }
    });
  }

  void getLemburKepalaBagian(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? idPegawai = pref.getString("id_pegawai");
    String? idKepalaBagian = pref.getString("idKepalaBagian");
    emit(GetLemburLoading());
    repository!.getLemburKepalaBagian(context, idPegawai).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      if (statusCode == 200 || statusCode == 201) {
        emit(GetLemburLoaded(statusCode: statusCode, model: modelLemburFromJson(jsonEncode(json)), idPegawai: int.parse(idPegawai!)));
      } else {
        emit(GetLemburFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
