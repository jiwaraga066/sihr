import 'package:sihr/source/env/env.dart';

class ApiPegawai {
  static getPegawai(id) {
    return "$url/api/v1/m_pegawai/$id";
  }
}
