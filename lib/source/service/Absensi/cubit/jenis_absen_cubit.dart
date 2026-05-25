import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sihr/source/repository/RepositoryAbsensi.dart';

import '../../../model/ModelJenisAbsen/modelJenisAbsen.dart';

part 'jenis_absen_state.dart';

class JenisAbsenCubit extends Cubit<JenisAbsenState> {
  final AbsensiRepository? repository;
  JenisAbsenCubit({this.repository}) : super(JenisAbsenInitial());

  void getJenisAbsensi(context) {
    emit(JenisAbsenLoading());
    repository!.getJenisAbsensi(context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print(json);
      if (statusCode == 200 || statusCode == 201) {
        emit(JenisAbsenLoaded(statusCode: statusCode, model: modelJenisAbsenFromJson(jsonEncode(json))));
      } else {
        emit(JenisAbsenFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
