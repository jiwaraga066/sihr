import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/repository/repositoryCuti.dart';

part 'create_cuti_state.dart';

class CreateCutiCubit extends Cubit<CreateCutiState> {
  final CutiRepository? repository;
  CreateCutiCubit({this.repository}) : super(CreateCutiInitial());

  void createCuti(jeniscuti, tglMulai, tglSelesai, keterangan, tglPengajuan, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    var body = FormData.fromMap({
      "id_pegawai": "$idPegawai",
      "id_jenis_cuti": "$jeniscuti",
      "tgl_mulai": "$tglMulai",
      "tgl_selesai": "$tglSelesai",
      "keterangan": "$keterangan",
      "status": "0",
      "tgl_input": "$tglPengajuan",
      "user_acc": "",
      "tgl_acc": ""
    });
    // print(body.fields);
    emit(CreateCutiLoading());
    repository!.createCuti(body, context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("create cuti: $json");
      if (statusCode == 200 || statusCode == 201) {
        emit(CreateCutiLoaded(statusCode: statusCode, json: json));
      } else {
        emit(CreateCutiFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
