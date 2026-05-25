import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/env/env.dart';
import 'package:sihr/source/repository/RepositoryLogBook.dart';

part 'update_log_book_perawat_state.dart';

class UpdateLogBookPerawatCubit extends Cubit<UpdateLogBookPerawatState> {
  final RepositoryLogBook? repository;
  UpdateLogBookPerawatCubit({this.repository}) : super(UpdateLogBookPerawatInitial());
  void updatelogbook(context, tanggal, jumlah, idmlogbook, keterangan, jenis) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    var body = {
      "id_pegawai": "$idPegawai",
      "id_m_logbook": "$idmlogbook",
      "tanggal": "$tanggal",
      "jumlah": "$jumlah",
      "keterangan": "$keterangan",
      "jenis": "$jenis",
      "status": "$valuestatus",
    };
    print(body);
    emit(UpdateLogBookPerawatLoading());
    repository!.updateLogBookPerawat(context, body, idlogbook).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print(json);
      if (statusCode == 200 || statusCode == 201) {
        emit(UpdateLogBookPerawatLoaded(statusCode: statusCode, json: json));
      } else {
        emit(UpdateLogBookPerawatFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
