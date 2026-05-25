import 'package:sihr/source/env/env.dart';

class ApiAbsensi {
  static updateAbsensi(idAbsensi) {
    return "$url/api/v1/t_absensi/$idAbsensi";
  }

  static postAbsensi() {
    return "$url/api/v1/t_absensi";
  }

  static getAbsensi() {
    return "$url/api/v1/t_absensi";
  }
  static getAbsensiDate(tglAwal, tglAkhir) {
    return "$url/api/v1/t_absensi?tanggal_awal=$tglAwal&tanggal_akhir=$tglAkhir";
  }

  static getSisaAbsensi() {
    return "$url/api/v1/t_absensi?sisa_absen=y";
  }

  static getJenisAbsensi() {
    return "$url/api/v1/m_jenis_absen";
  }
}
