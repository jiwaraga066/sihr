import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sihr/source/env/env.dart';
import 'package:sihr/source/widget/widgetCheckPermision.dart';

part 'check_permission_state.dart';

class CheckPermissionCubit extends Cubit<CheckPermissionState> {
  CheckPermissionCubit() : super(CheckPermissionInitial());

  Future<void> checkPermissionGranted(context) async {
    storagePermission = await Permission.manageExternalStorage.status;
    locationPermission = await Permission.location.status;
    cameraPermission = await Permission.camera.status;
    print(storagePermission);
    print(locationPermission);
    print(cameraPermission);
    if (!storagePermission!.isGranted || !locationPermission!.isGranted || !cameraPermission!.isGranted) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (context) {
        return CheckPermissionView(onPermissionRequest: () async {
          await Permission.manageExternalStorage.request();
          await Permission.location.request();
          await Permission.camera.request();
          Navigator.pop(context);
        }, onCancel: () {
          Navigator.pop(context);
        });
      },
    );
    }
  }
}
