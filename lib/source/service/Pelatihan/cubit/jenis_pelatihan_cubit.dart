import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sihr/source/model/ModelJenisPelatihan/modelJenisPelatihan.dart';
import 'package:sihr/source/repository/RepositoryPelatihan.dart';

part 'jenis_pelatihan_state.dart';

class JenisPelatihanCubit extends Cubit<JenisPelatihanState> {
  final PelatihanRepository? repository;
  JenisPelatihanCubit({this.repository}) : super(JenisPelatihanInitial());

  void jenisPelatihan(context) async {
    emit(JenisPelatihanLoading());
    repository!.jenisPelatihan(context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      if (statusCode == 200 || statusCode == 201) {
        emit(JenisPelatihanLoaded(statusCode: statusCode, modeljenispelatihan: modeljenispelatihanFromJson(jsonEncode(json))));
      } else {
        emit(JenisPelatihanFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
