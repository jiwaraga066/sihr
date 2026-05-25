import 'package:sihr/source/env/env.dart';

class ApiSlipGaji {
  static getSlip(bulan, tahun, idPegawai) {
    return "$url/api/v1/t_payroll?bulan=$bulan&tahun=$tahun&id_pegawai=$idPegawai";
  }

  static getPayroll(bulan, tahun, idPegawai) {
    return "$url/api/v1/t_payroll?bulan=$bulan&tahun=$tahun&id_pegawai=$idPegawai&cpayroll=slip_gaji";
  }
}
