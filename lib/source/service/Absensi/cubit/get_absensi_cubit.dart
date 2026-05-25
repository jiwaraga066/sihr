import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/model/ModelDataAbsensi/modelDataAbsensi.dart';
import 'package:sihr/source/repository/RepositoryAbsensi.dart';

part 'get_absensi_state.dart';

class GetAbsensiCubit extends Cubit<GetAbsensiState> {
  final AbsensiRepository? repository;
  GetAbsensiCubit({this.repository}) : super(GetAbsensiInitial());

  void initial() {
    emit(GetAbsensiInitial());
  }

  void getAbsensi(context, tglAwal, tglAkhir) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? idPegawai = pref.getString("id_pegawai");
    print(idPegawai);
    emit(GetAbsensiLoading());
    repository!.getAbsensi(context, tglAwal, tglAkhir).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      if (statusCode == 200 || statusCode == 201) {
        emit(GetAbsensiLoaded(statusCode: statusCode, idPegawai: int.parse(idPegawai!), model: modelDataAbsensiFromJson(jsonEncode(json))));
      } else {
        emit(GetAbsensiFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
