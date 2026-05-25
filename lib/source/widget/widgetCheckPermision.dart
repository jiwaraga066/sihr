import 'package:flutter/material.dart';
import 'package:sihr/source/env/env.dart';
import 'package:sihr/source/widget/customButton2.dart';

class CheckPermissionView extends StatelessWidget {
  VoidCallback? onPermissionRequest, onCancel;
  CheckPermissionView({super.key, this.onPermissionRequest, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: whiteCustom2,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Permissions Required",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Image.asset("assets/images/vectorpermision.jpg"),
          const SizedBox(height: 10),
          const Text("This app needs access to your files, location, and camera."),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: CustomButton2(
              onTap: onPermissionRequest,
              backgroundColor: hijau,
              text: "Izinkan",
              textStyle: const TextStyle(color: whiteCustom, fontFamily: 'JakartaSansSemiBold', fontSize: 18),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: CustomButton2(
              onTap: onCancel,
              backgroundColor: whiteCustom2,
              text: "Tutup",
              textStyle: const TextStyle(color: hijau, fontFamily: 'JakartaSansSemiBold', fontSize: 18),
            ),
          ),
         
        ],
      ),
    );
  }
}
