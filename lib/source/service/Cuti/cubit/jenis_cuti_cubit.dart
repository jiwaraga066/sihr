import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sihr/source/model/ModelJenisCuti/modelJenisCuti.dart';
import 'package:sihr/source/repository/repositoryCuti.dart';

part 'jenis_cuti_state.dart';

class JenisCutiCubit extends Cubit<JenisCutiState> {
  final CutiRepository? repository;
  JenisCutiCubit({this.repository}) : super(JenisCutiInitial());

  void getjeniscuti(context) async {
    emit(JenisCutiLoading());
    repository!.jeniscuti(context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      if (statusCode == 200 || statusCode == 201) {
        emit(JenisCutiLoaded(statusCode: statusCode, model: modelJenisCutiFromJson(jsonEncode(json))));
      } else {
        emit(JenisCutiFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
