import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/repository/repositoryIzin.dart';

part 'create_izin_state.dart';

class CreateIzinCubit extends Cubit<CreateIzinState> {
  final IzinRepository? repository;
  CreateIzinCubit({this.repository}) : super(CreateIzinInitial());

  void createIzin(tanggal, alasan, keterangan, idjenis, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    var datenow = DateTime.now();
    var body = FormData.fromMap({
      "id_pegawai": "$idPegawai",
      "tanggal": tanggal,
      "alasan": "$alasan",
      "status": "0",
      "id_jenis_izin": "$idjenis",
      "keterangan": "$keterangan",
      "tgl_input": "$datenow"
    });
    print(body.fields);
    emit(CreateIzinLoading());
    repository!.createIzin(body, context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      if (statusCode == 200 || statusCode == 201) {
        emit(CreateIzinLoaded(statusCode: statusCode, json: json));
      } else {
        emit(CreateIzinFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
