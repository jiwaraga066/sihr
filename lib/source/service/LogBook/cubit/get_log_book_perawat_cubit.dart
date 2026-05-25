import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/model/ModelLogBook/modelLogBookPerawat.dart';
import 'package:sihr/source/repository/RepositoryLogBook.dart';

part 'get_log_book_perawat_state.dart';

class GetLogBookPerawatCubit extends Cubit<GetLogBookPerawatState> {
  final RepositoryLogBook? repository;
  GetLogBookPerawatCubit({this.repository}) : super(GetLogBookPerawatInitial());

  void getLogBookPerawat(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    emit(GetLogBookPerawatLoading());
    repository!.getLogBookPerawat(context, idPegawai).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("PERAWAT: $statusCode");
      if (statusCode == 200 || statusCode == 201) {
        emit(GetLogBookPerawatLoaded(statusCode: statusCode, model: modelLogBookPerawatFromJson(jsonEncode(json))));
      } else {
        emit(GetLogBookPerawatFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
