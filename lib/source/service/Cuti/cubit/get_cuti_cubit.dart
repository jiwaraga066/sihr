import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/model/ModelCuti/modelCuti.dart';
import 'package:sihr/source/repository/repositoryCuti.dart';

part 'get_cuti_state.dart';

class GetCutiCubit extends Cubit<GetCutiState> {
  final CutiRepository? repository;
  GetCutiCubit({this.repository}) : super(GetCutiInitial());

  void getCuti(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? idPegawai = pref.getString("id_pegawai");
    emit(GetCutiLoading());
    repository!.getCuti(context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print(json);
      if (statusCode == 200 || statusCode == 201) {
        emit(GetCutiLoaded(statusCode: statusCode, model: modelCutiFromJson(jsonEncode(json)), idPegawai: int.parse(idPegawai!)));
      } else {
        emit(GetCutiFailed(statusCode: statusCode, json: json));
      }
    });
  }

  void getCutiKepalaBagian(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? idPegawai = pref.getString("id_pegawai");
    String? idKepalaBagian = pref.getString("idKepalaBagian");
    emit(GetCutiLoading());
    repository!.getCutiKepalaBagian(context, idPegawai).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print(json);
      if (statusCode == 200 || statusCode == 201) {
        emit(GetCutiLoaded(statusCode: statusCode, model: modelCutiFromJson(jsonEncode(json)), idPegawai: int.parse(idPegawai!)));
      } else {
        emit(GetCutiFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
