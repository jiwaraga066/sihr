import 'package:sihr/source/env/env.dart';

class ApiLembur {
  static getLembur() {
    return "$url/api/v1/t_lembur";
  }

  static getLemburKepalaBagian(idKepalaBagian) {
    return "$url/api/v1/t_lembur?id_kepala_bagian=$idKepalaBagian";
  }

  static createLembur() {
    return "$url/api/v1/t_lembur";
  }
}
