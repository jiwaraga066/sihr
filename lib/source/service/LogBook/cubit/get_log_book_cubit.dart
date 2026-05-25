import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/model/ModelLogBook/modelLogBook.dart';
import 'package:sihr/source/repository/RepositoryLogBook.dart';

part 'get_log_book_state.dart';

class GetLogBookCubit extends Cubit<GetLogBookState> {
  final RepositoryLogBook? repository;
  GetLogBookCubit({this.repository}) : super(GetLogBookInitial());

  void getLogBook(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    emit(GetLogBookLoading());
    repository!.getLogBook(context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("LOG BOOK: $json");

      if (statusCode == 200 || statusCode == 201) {
        emit(GetLogBookLoaded(statusCode: statusCode, idPegawai: int.parse(idPegawai!), model: modelLogBookFromJson(jsonEncode(json))));
      } else {
        emit(GetLogBookFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
