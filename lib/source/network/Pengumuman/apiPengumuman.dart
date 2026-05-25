import 'package:sihr/source/env/env.dart';

class Apipengumuman {
  static pengumuman() {
    return "$url/api/v1/t_pengumuman";
  }

  static pengumumanPeserta(id) {
    return "$url/api/v1/t_pengumuman_peserta/$id?by=id_pegawai";
  }

  static updatePengumumanPeserta(id) {
    return "$url/api/v1/t_pengumuman_peserta/$id";
  }
}
