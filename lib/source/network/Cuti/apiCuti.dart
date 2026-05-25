import 'package:sihr/source/env/env.dart';

class ApiCuti {
  static jeniscuti() {
    return "$url/api/v1/m_jenis_cuti";
  }

  static getCuti() {
    return "$url/api/v1/t_cuti";
  }
  static getCutiKepalaBagian(idKepalaBagian) {
    return "$url/api/v1/t_cuti?id_kepala_bagian=$idKepalaBagian";
  }

  static createCuti() {
    return "$url/api/v1/t_cuti";
  }
}
