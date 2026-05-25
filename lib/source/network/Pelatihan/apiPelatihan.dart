import 'package:sihr/source/env/env.dart';

class ApiPelatihan {
  static jenisPelatihan() {
    return "$url/api/v1/m_jenispelatihan";
  }

  static kategoriPelatihan() {
    return "$url/api/v1/t_pelatihan";
  }

  static pelatihan() {
    return "$url/api/v1/t_partisipasi_pelatihan";
  }

  static postpartisipasipelatihan() {
    return "$url/api/v1/t_partisipasi_pelatihan";
  }

  static updatepartisipasipelatihan(id) {
    return "$url/api/v1/t_partisipasi_pelatihan/$id";
  }
}
