import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sihr/source/model/ModelJenisIzin/modeljenisIzin.dart';
import 'package:sihr/source/repository/repositoryIzin.dart';

part 'jenis_izin_state.dart';

class JenisIzinCubit extends Cubit<JenisIzinState> {
  final IzinRepository? repository;
  JenisIzinCubit({this.repository}) : super(JenisIzinInitial());

  void getjenisIzin(context) async {
    emit(JenisIzinLoading());
    repository!.jenisizin(context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      if (statusCode == 200 || statusCode == 201) {
        emit(JenisIzinLoaded(statusCode: statusCode, model: modelJenisizinFromJson(jsonEncode(json))));
      } else {
        emit(JenisIzinFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
