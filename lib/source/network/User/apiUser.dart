import 'package:sihr/source/env/env.dart';

class ApiUser {
  static login() {
    return "$url/api/v1/login";
  }

  static session() {
    return "$url/api/v1/session";
  }

  static changePassword(iduser) {
    return "$url/api/v1/user/$iduser";
  }
}
