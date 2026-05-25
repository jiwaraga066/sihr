import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sihr/source/model/ModelSisaAbsen/modelSisaAbsen.dart';
import 'package:sihr/source/repository/RepositoryAbsensi.dart';

part 'get_sisa_absen_state.dart';

class GetSisaAbsenCubit extends Cubit<GetSisaAbsenState> {
  final AbsensiRepository? repository;
  GetSisaAbsenCubit({this.repository}) : super(GetSisaAbsenInitial());

  void getSisaAbsensi(context) async {
    emit(GetSisaAbsenLoading());
    repository!.getSisaAbsensi(context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      
      if (statusCode == 200 || statusCode == 201) {
        emit(GetSisaAbsenLoaded(statusCode: statusCode, model: modelSisaAbsenFromJson(jsonEncode(json))));
      } else {
        emit(GetSisaAbsenFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
