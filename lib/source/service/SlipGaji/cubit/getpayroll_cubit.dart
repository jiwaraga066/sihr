import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/model/ModelSlipGaji/modelPayrol.dart';
import 'package:sihr/source/repository/RepositorySlipGaji.dart';

part 'getpayroll_state.dart';

class GetpayrollCubit extends Cubit<GetpayrollState> {
  final RepositorySlipGaji? repository;

  GetpayrollCubit({this.repository}) : super(GetpayrollInitial());

  void getPayroll(bulan, tahun, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? idPegawai = pref.getString("id_pegawai");
    repository!.getPayroll(bulan, tahun, idPegawai, context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("Payroll: $json");
      emit(GetpayrollLoading());
      if (statusCode == 200 || statusCode == 201) {
        emit(GetpayrollLoaded(statusCode: statusCode, model: modelPayrollFromJson(jsonEncode(json))));
      } else {
        emit(GetpayrollFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
