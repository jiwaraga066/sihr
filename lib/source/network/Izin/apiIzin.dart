import 'package:sihr/source/env/env.dart';

class Apiizin {
  static jenisIzin() {
    return "$url/api/v1/m_jenis_izin";
  }

  static createIzin() {
    return "$url/api/v1/t_izin";
  }

  static getIzin() {
    return "$url/api/v1/t_izin";
  }

  static getIzinKepalaBagian(idKepalaBagian) {
    return "$url/api/v1/t_izin?id_kepala_bagian=$idKepalaBagian";
  }
}
