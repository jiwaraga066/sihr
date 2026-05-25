import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/repository/RepositoryLogBook.dart';

part 'create_log_book_state.dart';

class CreateLogBookCubit extends Cubit<CreateLogBookState> {
  final RepositoryLogBook? repository;
  CreateLogBookCubit({this.repository}) : super(CreateLogBookInitial());

  void createLogBook(context, namalogbook, tanggal, ket, file) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    var body = FormData.fromMap({
      "id_pegawai": "$idPegawai",
      "nama_log": "$namalogbook",
      "tanggal": "$tanggal",
      "keterangan": "$ket",
      "upload": await MultipartFile.fromFile(file!.path, filename: file.name),
    });
    // print(file);
    // print(body.fields);
    emit(CreateLogBookLoading());
    repository!.createLogBook(context, body).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("Create LogBook: $json");
      if (statusCode == 200 || statusCode == 201) {
        emit(CreateLogBookLoaded(statusCode: statusCode, json: json));
      } else {
        emit(CreateLogBookFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
