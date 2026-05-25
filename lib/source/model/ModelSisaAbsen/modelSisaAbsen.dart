// To parse this JSON data, do
//
//     final modelSisaAbsen = modelSisaAbsenFromJson(jsonString);

import 'dart:convert';

ModelSisaAbsen modelSisaAbsenFromJson(String str) => ModelSisaAbsen.fromJson(json.decode(str));

String modelSisaAbsenToJson(ModelSisaAbsen data) => json.encode(data.toJson());

class ModelSisaAbsen {
  final String? message;
  final Data? data;

  ModelSisaAbsen({
    this.message,
    this.data,
  });

  factory ModelSisaAbsen.fromJson(Map<String, dynamic> json) => ModelSisaAbsen(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? jatahCuti;
  final int? cutiTerpakai;
  final int? sisaCuti;
  final int? kehadiran;
  final int? izin;

  Data({
    this.jatahCuti,
    this.cutiTerpakai,
    this.sisaCuti,
    this.kehadiran,
    this.izin,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        jatahCuti: json["jatah_cuti"] ?? 0,
        cutiTerpakai: json["cuti_terpakai"] ?? 0,
        sisaCuti: json["sisa_cuti"] ?? 0,
        kehadiran: json["kehadiran"] ?? 0,
        izin: json["izin"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "jatah_cuti": jatahCuti,
        "cuti_terpakai": cutiTerpakai,
        "sisa_cuti": sisaCuti,
        "kehadiran": kehadiran,
        "izin": izin,
      };
}
