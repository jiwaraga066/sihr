import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sihr/source/model/ModelPengumuman/ModelPengumuman.dart';
import 'package:sihr/source/repository/RepositoryPengumuman.dart';

part 'get_pengumuman_state.dart';

class GetPengumumanCubit extends Cubit<GetPengumumanState> {
  final Repositorypengumuman? repository;
  GetPengumumanCubit({this.repository}) : super(GetPengumumanInitial());

  void getPengumuman(context) {
    emit(GetPengumumanLoading());
    repository!.getPengumuman(context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print(json);
     if (statusCode == 200 || statusCode == 201) {
        emit(GetPengumumanLoaded(statusCode: statusCode, model: modelPengumumanFromJson(jsonEncode(json))));
      } else {
        emit(GetPengumumanFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
