import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/model/ModelPelatihan/modelPelatihan.dart';
import 'package:sihr/source/repository/RepositoryPelatihan.dart';

part 'pelatihan_state.dart';

class PelatihanCubit extends Cubit<PelatihanState> {
  final PelatihanRepository? repository;
  PelatihanCubit({this.repository}) : super(PelatihanInitial());

  void getPelatihan(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? idPegawai = pref.getString("id_pegawai");
    emit(PelatihanLoading());
    repository!.getPelatihan(context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("JSON:  $json");
      if (statusCode == 200 || statusCode == 201) {
        emit(PelatihanLoaded(statusCode: statusCode, modelPelatihan: modelPelatihanFromJson(jsonEncode(json)), idPegawai: int.parse(idPegawai!)));
      } else {
        emit(PelatihanFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
