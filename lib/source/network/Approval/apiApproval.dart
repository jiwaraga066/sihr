import 'package:sihr/source/env/env.dart';

class ApiApproval {
  static approvalCuti(id) {
    return "$url/api/v1/t_cuti/$id";
  }

  static approvalLembur(id) {
    return "$url/api/v1/t_lembur/$id";
  }

  static approvalIzin(id) {
    return "$url/api/v1/t_izin/$id";
  }
}
