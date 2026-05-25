import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/model/ModelLogBook/modelMasterLogBook.dart';
import 'package:sihr/source/repository/RepositoryLogBook.dart';

part 'master_log_book_state.dart';

class MasterLogBookCubit extends Cubit<MasterLogBookState> {
  final RepositoryLogBook? repository;
  MasterLogBookCubit({this.repository}) : super(MasterLogBookInitial());

  void getMasterLogBook(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idjabatan = pref.getString("idjabatan");
    emit(MasterLogBookLoading());
    repository!.masterLogBook(context, idjabatan).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("$idjabatan");
      print("Master Log book: $json");
      if (statusCode == 200 || statusCode == 201) {
        emit(MasterLogBookLoaded(statusCode: statusCode, model: modelMasterLogBookFromJson(jsonEncode(json))));
      } else {
        emit(MasterLogBookFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
