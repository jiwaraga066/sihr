import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/model/ModelPengumuman/ModelPengumumanPeserta.dart';
import 'package:sihr/source/repository/RepositoryPengumuman.dart';

part 'get_pengumuman_peserta_state.dart';

class GetPengumumanPesertaCubit extends Cubit<GetPengumumanPesertaState> {
  final Repositorypengumuman? repository;
  GetPengumumanPesertaCubit({this.repository}) : super(GetPengumumanPesertaInitial());

  void getPengumumanPeserta(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    emit(GetPengumumanPesertaLoading());
    repository!.getPengumumanPeserta(context, idPegawai).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print(json);
      if (statusCode == 200 || statusCode == 201) {
        emit(GetPengumumanPesertaLoaded(statusCode: statusCode, model: modelPengumumanPesertaFromJson(jsonEncode(json))));
      } else {
        emit(GetPengumumanPesertaFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
