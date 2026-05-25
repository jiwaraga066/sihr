import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihr/source/env/env.dart';
import 'package:sihr/source/repository/RepositoryAbsensi.dart';
import 'package:sihr/source/widget/customDialog.dart';

part 'post_absensi_state.dart';

class PostAbsensiCubit extends Cubit<PostAbsensiState> {
  final AbsensiRepository? repository;
  PostAbsensiCubit({this.repository}) : super(PostAbsensiInitial());

  void postAbsensi(XFile? foto, lat, long, keterangan, tipeScan, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idPegawai = pref.getString("id_pegawai");
    var idShift = pref.getString("idShift");
    var username = pref.getString("username");
    var body = FormData.fromMap({
      "id_pegawai": "$idPegawai",
      // "tanggal": "$tanggal",
      // "waktu_masuk": "08:00:00",
      // "waktu_keluar": "12:00:00",
      "status": "0",
      "jenis": "$tipeScan",
      "keterangan": "$keterangan",
      "foto": await MultipartFile.fromFile(foto!.path, filename: foto.name),
      "latt": "$lat",
      "att": "$long",
      "id_shift": "$idShift",
    });
    print(body.fields);
    // -6.803123267471703, 108.61565805428894
    // num distanceInMeters = Geolocator.distanceBetween(lat, long, -7.002724, 107.572764);
    EasyLoading.show();
    await Geolocator.getCurrentPosition().then((location) async {
      print("isMock : ${location.isMocked}");
      // print(placemarks[0]);
      if (location.isMocked == true) {
        EasyLoading.dismiss();
        MyDialog.dialogAlert(context, "Maaf, fake gps terdeteksi");
      }
      //  else if (idShift == null) {
      //   EasyLoading.dismiss();
      //   MyDialog.dialogAlert(context, "Maaf, anda tidak punya jadwal shift");
      // }
      else {
        EasyLoading.dismiss();
        num distanceInMeters = Geolocator.distanceBetween(lat, long, latitudePlace, longitudePlace);
        print(distanceInMeters);

        if (tipeScan == 1 || tipeScan == 3 || tipeScan == 7) {
          if (username == "Super Ngadmin") {
            print("bisa absen");
            emit(PostAbsensiLoading());
            repository!.postAbsensi(body, context).then((value) {
              var json = value.data;
              var statusCode = value.statusCode;
              print("POST: $statusCode");
              if (statusCode == 200 || statusCode == 201) {
                pref.setString("idAbsensi", json['data']['id'].toString());
                emit(PostAbsensiLoaded(statusCode: statusCode, json: json));
              } else {
                emit(PostAbsensiFailed(statusCode: statusCode, json: json));
              }
            });
          } else {
            if (distanceInMeters <= 150) {
              print("bisa absen");
              emit(PostAbsensiLoading());
              repository!.postAbsensi(body, context).then((value) {
                var json = value.data;
                var statusCode = value.statusCode;
                print("POST: $statusCode");
                if (statusCode == 200 || statusCode == 201) {
                  pref.setString("idAbsensi", json['data']['id'].toString());
                  emit(PostAbsensiLoaded(statusCode: statusCode, json: json));
                } else {
                  emit(PostAbsensiFailed(statusCode: statusCode, json: json));
                }
              });
            } else {
              MyDialog.dialogAlert(context, "Maaf, anda jauh dari radius ");
            }
          }
        } else if (tipeScan == 2 || tipeScan == 4 || tipeScan == 6 || tipeScan == 8) {
          if (username == "Super Ngadmin") {
            print("bisa absen");
            emit(PostAbsensiLoading());
            var idAbsensi = pref.getString("idAbsensi");
            print(idAbsensi);
            repository!.postAbsensi(body, context).then((value) {
              var json = value.data;
              var statusCode = value.statusCode;
              print("POST: $statusCode");
              print("POST: $json");
              if (statusCode == 200 || statusCode == 201) {
                emit(PostAbsensiLoaded(statusCode: statusCode, json: json));
              } else {
                emit(PostAbsensiFailed(statusCode: statusCode, json: json));
              }
            });
          } else {
            if (distanceInMeters <= 150) {
              print("bisa absen");
              emit(PostAbsensiLoading());
              var idAbsensi = pref.getString("idAbsensi");
              print(idAbsensi);
              repository!.postAbsensi(body, context).then((value) {
                var json = value.data;
                var statusCode = value.statusCode;
                print("POST: $statusCode");
                print("POST: $json");
                if (statusCode == 200 || statusCode == 201) {
                  emit(PostAbsensiLoaded(statusCode: statusCode, json: json));
                } else {
                  emit(PostAbsensiFailed(statusCode: statusCode, json: json));
                }
              });
            } else {
              MyDialog.dialogAlert(context, "Maaf, anda jauh dari radius ");
            }
          }
        } else {
          print("bisa absen");
          emit(PostAbsensiLoading());
          repository!.postAbsensi(body, context).then((value) {
            var json = value.data;
            var statusCode = value.statusCode;
            print("POST: $json");
            MyDialog.dialogAlert(context, "$json");
            if (statusCode == 200 || statusCode == 201) {
              pref.setString("idAbsensi", json['data']['id'].toString());
              emit(PostAbsensiLoaded(statusCode: statusCode, json: json));
            } else {
              emit(PostAbsensiFailed(statusCode: statusCode, json: json));
            }
          });
        }
      }
    });
  }
}
