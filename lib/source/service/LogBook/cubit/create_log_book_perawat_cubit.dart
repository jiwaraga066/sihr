import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/repository/RepositoryLogBook.dart';

part 'create_log_book_perawat_state.dart';

class CreateLogBookPerawatCubit extends Cubit<CreateLogBookPerawatState> {
  final RepositoryLogBook? repository;
  CreateLogBookPerawatCubit({this.repository}) : super(CreateLogBookPerawatInitial());

  void createlogbook(context, tanggal, jumlah, idmlogbook, keterangan, jenis ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    var body = {
      "id_pegawai": "$idPegawai",
      "id_m_logbook": "$idmlogbook",
      "tanggal": "$tanggal",
      "jumlah": "$jumlah",
      "keterangan": "$keterangan",
      "jenis": "$jenis",
      "status": "0",
    };
    print(body);
    emit(CreateLogBookPerawatLoading());
    repository!.createLogBookPerawat(context, body).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print(json);
      if (statusCode == 200 || statusCode == 201) {
        emit(CreateLogBookPerawatLoaded(statusCode: statusCode, json: json));
      } else {
        emit(CreateLogBookPerawatFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
