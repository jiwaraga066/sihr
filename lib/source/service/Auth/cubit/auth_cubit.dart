
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/model/ModelUser/modelUser.dart';
import 'package:sihr/source/repository/RepositoryAuth.dart';
import 'package:sihr/source/router/string.dart';
import 'package:sihr/source/widget/customDialog.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuhtRepository? repository;
  AuthCubit({this.repository}) : super(AuthInitial());

  void logout(context) async {
    MyDialog.dialogLoading(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("token");
    pref.remove("idShift");
    pref.remove("id_pegawai");
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushNamedAndRemoveUntil(context, loginScreen, (Route<dynamic> route) => false);
  }

  void checkemailLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    print(email);
    if (email != null) {
      emit(AuthSaveEmail(email: email));
    } else {
      emit(AuthSaveEmail(email: ""));
    }
  }

  void checkSession(context) async {
    emit(AuthLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    if (token != null) {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamedAndRemoveUntil(context, dashboardScreen, (Route<dynamic> route) => false);
    } else {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamedAndRemoveUntil(context, loginScreen, (Route<dynamic> route) => false);
    }
  }

  void session(context) async {
    emit(AuthLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var username = pref.getString("username");
    var email = pref.getString("email");
    var phoneNumber = pref.getString("phoneNumber");
    var data = {"username": username, "email": email, "phoneNumber": phoneNumber};
    repository!.session(context).then((value) async {
      var json = value.data;
      var statusCode = value.statusCode;
      print(json);
      if (statusCode == 200 || statusCode == 201) {
        pref.setString("id_pegawai", json['user']['id_pegawai'].toString());
        emit(AuthLoaded(statusCode: statusCode, json: data));
        // if (from != 'home') {
        // await Future.delayed(const Duration(seconds: 1));
        // Navigator.pushNamedAndRemoveUntil(context, dashboardScreen, (Route<dynamic> route) => false);
        // }
      } else if (token == null) {
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushNamedAndRemoveUntil(context, loginScreen, (Route<dynamic> route) => false);
      } else if (statusCode != 200) {
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushNamedAndRemoveUntil(context, loginScreen, (Route<dynamic> route) => false);
      }
    });
  }

  void login(email, password, rememberme, context) async {
    emit(AuthLoading());
    var body = FormData.fromMap({"email": "$email", "password": "$password"});
    SharedPreferences pref = await SharedPreferences.getInstance();
    MyDialog.dialogLoading(context);
    repository!.login(body, context).then((value) async {
      var json = value.data;
      var statusCode = value.statusCode;
      Navigator.of(context).pop();
    if (statusCode == 200 || statusCode == 201) {
        if (rememberme == true) {
          pref.setString("email", email);
        }
        pref.setString("id", json['data']['id'].toString());
        pref.setString("username", json['data']['username']);

        pref.setString("phoneNumber", json['data']['phoneNumber']);
        pref.setString("token", json['data']['token']);
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushNamedAndRemoveUntil(context, dashboardScreen, (Route<dynamic> route) => false);
      } else {
        MyDialog.dialogAlert(context, json['message']);
      }
      print("login: \n$json");
      emit(AuthLoaded(statusCode: statusCode, json: json));
    });
  }
}
