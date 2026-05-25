import 'package:sihr/source/env/env.dart';

class ApiShift {
  static getShift(id) {
    return "$url/api/v1/m_shift/$id";
  }
}
