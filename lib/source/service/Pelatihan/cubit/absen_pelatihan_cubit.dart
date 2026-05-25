
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/env/env.dart';
import 'package:sihr/source/repository/RepositoryPelatihan.dart';

part 'absen_pelatihan_state.dart';

class AbsenPelatihanCubit extends Cubit<AbsenPelatihanState> {
  final PelatihanRepository? repository;
  AbsenPelatihanCubit({this.repository}) : super(AbsenPelatihanInitial());

  void absenPartisipasi(context, XFile? foto, lat, long) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    var datenow = DateTime.now();
    FormData body = FormData.fromMap({
      "id_pegawai": "$idPegawai",
      "id_pelatihan": "$id_pelatihan",
      "status": "Mengikuti",
      "resume": "tes",
      "masuk": "$datenow",
      "foto": await MultipartFile.fromFile(foto!.path, filename: foto.name),
      "latt": "$lat",
      "att": "$long",
    });
    print(body.fields);
    emit(AbsenPelatihanLoading());
    // print(body.fields);
    repository!.updatePartisipasiPelatihan(context, id_partisipasi, body).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("POST PARTISIPASI: \n$json");
      if (statusCode == 200 || statusCode == 201) {
        emit(AbsenPelatihanLoaded(statusCode: statusCode, json: json));
      } else {
        emit(AbsenPelatihanFailed(statusCode: statusCode, json: json));
      }
    });
  }

  void updatePartisipasi(context, resume) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");

    var body = {
      "id_pegawai": "$idPegawai",
      "id_pelatihan": "$id_pelatihan",
      "status": "Mengikuti",
      "resume": "$resume",
    };
    print(body);
    print(id_partisipasi);
    emit(AbsenPelatihanLoading());
    repository!.updatePartisipasiPelatihan(context, id_partisipasi, body).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("UPDATE PARTISIPASI: \n$json");
      print(statusCode);
      if (statusCode == 200 || statusCode == 201) {
        emit(AbsenPelatihanLoaded(statusCode: statusCode, json: json));
      } else {
        emit(AbsenPelatihanFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
