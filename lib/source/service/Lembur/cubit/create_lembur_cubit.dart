import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/repository/repositoryLembur.dart';

part 'create_lembur_state.dart';

class CreateLemburCubit extends Cubit<CreateLemburState> {
  final LemburRepository? repository;
  CreateLemburCubit({this.repository}) : super(CreateLemburInitial());

  void createLembur(tanggal, jamMulai, jamSelesai, keterangan, jenis, kategori, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    var body = FormData.fromMap({
      "id_pegawai": "$idPegawai",
      "tanggal": "$tanggal",
      "jam_mulai": "$jamMulai",
      "jam_selesai": "$jamSelesai",
      "keterangan": "$keterangan",
      // "noreff": "109120971205",
      "status": "0",
      "jenis": "$jenis",
      "kategori": "$kategori"
    });
    print(body.fields);
    emit(CreateLemburLoading());
    repository!.createLembur(body, context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("create lembur: $json");
      if (statusCode == 200 || statusCode == 201) {
        emit(CreateLemburLoaded(statusCode: statusCode, json: json));
      } else {
        emit(CreateLemburFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
