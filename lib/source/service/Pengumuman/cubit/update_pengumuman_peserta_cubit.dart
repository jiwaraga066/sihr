import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/repository/RepositoryPengumuman.dart';

part 'update_pengumuman_peserta_state.dart';

class UpdatePengumumanPesertaCubit extends Cubit<UpdatePengumumanPesertaState> {
  final Repositorypengumuman? repository;
  UpdatePengumumanPesertaCubit({this.repository}) : super(UpdatePengumumanPesertaInitial());

  void updateResumePengumumanPeserta(context, id, resume) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    var body = FormData.fromMap({
      // "cekin": await MultipartFile.fromFile(foto!.path, filename: foto.name),
      "resume": "$resume",
    });
    print(body.fields);
    emit(UpdatePengumumanPesertaLoading());
    repository!.updatePengumumanPeserta(context, id, body).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("UPDATE NEWS: $statusCode");
      if (statusCode == 200 || statusCode == 201) {
        emit(UpdatePengumumanPesertaLoaded(statusCode: statusCode, json: json));
      } else {
        emit(UpdatePengumumanPesertaFailed(statusCode: statusCode, json: json));
      }
    });
  }

  void updateCheckInPengumumanPeserta(context, id, XFile? foto) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    var body = FormData.fromMap({
      "cekin": await MultipartFile.fromFile(foto!.path, filename: foto.name),
      // "resume": "$resume",
    });
    print(body.fields);
    emit(UpdatePengumumanPesertaLoading());
    repository!.updatePengumumanPeserta(context, id, body).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("UPDATE NEWS: $statusCode");
      if (statusCode == 200 || statusCode == 201) {
        emit(UpdatePengumumanPesertaLoaded(statusCode: statusCode, json: json));
      } else {
        emit(UpdatePengumumanPesertaFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
