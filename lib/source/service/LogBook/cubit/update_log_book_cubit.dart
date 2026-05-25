import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/env/env.dart';
import 'package:sihr/source/repository/RepositoryLogBook.dart';

part 'update_log_book_state.dart';

class UpdateLogBookCubit extends Cubit<UpdateLogBookState> {
  final RepositoryLogBook? repository;
  UpdateLogBookCubit({this.repository}) : super(UpdateLogBookInitial());

  void updateLogBook(context, namalogbook, tanggal, ket, file) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    var body = FormData.fromMap({
      "id_pegawai": "$idPegawai",
      "nama_log": "$namalogbook",
      "tanggal": "$tanggal",
      "keterangan": "$ket",
      "upload": await MultipartFile.fromFile(file!.path, filename: file.name),
    });
    print(idlogbook);
    print(body.fields);
    emit(UpdateLogBookLoading());
    repository!.updateLogBook(context, body, idlogbook).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("Update LogBook: $json");
      if (statusCode == 200 || statusCode == 201) {
        emit(UpdateLogBookLoaded(statusCode: statusCode, json: json));
      } else {
        emit(UpdateLogBookFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
