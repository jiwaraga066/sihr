import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/model/ModelPegawai/modelPegawai.dart';
import 'package:sihr/source/repository/repositoryPegawai.dart';
import 'package:sihr/source/widget/customDialog.dart';

part 'get_pegawai_state.dart';

class GetPegawaiCubit extends Cubit<GetPegawaiState> {
  final PegawaiRepository? repository;
  GetPegawaiCubit({this.repository}) : super(GetPegawaiInitial());

  void getPegawai(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    var shift = pref.getString("idShift");
    var username = pref.getString("username");
    print("shift: $username");
    emit(GetPegawaiLoading());
    repository!.getPegawai(context, idPegawai).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      // print(json);
      if (statusCode == 200 || statusCode == 201) {
        pref.setString('idKepalaBagian', json['data']['id_kepala_bagian'].toString());
        pref.setString('idjabatan', json['data']['id_jabatan'].toString());
        if (json['jadwal'] != null) {
          if (json['jadwal'].isNotEmpty) {
            // pref.setString('idShift', json['data']['shift']['id'].toString());
            pref.setString('idShift', json['jadwal'][0]['id_shift'].toString());
          } else {
            MyDialog.dialogAlert(context, "Maaf, jadwal shift kosong");
          }
        }
        emit(GetPegawaiLoaded(statusCode: statusCode, model: modelPegawaiFromJson(jsonEncode(json))));
      } else {
        emit(GetPegawaiFailed(statusCode: statusCode, messageError: "Ops, Terjadi Kesalahan"));
      }
    });
  }
}

// Materi presentasi :
// - Konsep History of
// virtual reality
// - Pengertian virtual
// reality
// - Contoh – contoh
// virtual reality