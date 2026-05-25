import 'package:sihr/source/env/env.dart';

class ApiLogBook {
  static masterLogBook(idjabatan) {
    return "$url/api/v1/m_logbook?id_jabatan=$idjabatan";
  }

  static getLogBook() {
    return "$url/api/v1/t_logbook";
  }

  static createLogBook() {
    return "$url/api/v1/t_logbook";
  }

  static updateLogBook(id) {
    return "$url/api/v1/t_logbook/$id";
  }

  static getLogBookPerawat(id) {
    return "$url/api/v1/t_logbookperawat/$id?by=id_pegawai";
  }

  static createLogBookPerawat() {
    return "$url/api/v1/t_logbookperawat";
  }

  static updateLogBookPerawat(id) {
    return "$url/api/v1/t_logbookperawat/$id";
  }
}
