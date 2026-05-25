// To parse this JSON data, do
//
//     final modelMasterLogBook = modelMasterLogBookFromJson(jsonString);

import 'dart:convert';

ModelMasterLogBook modelMasterLogBookFromJson(String str) => ModelMasterLogBook.fromJson(json.decode(str));

class ModelMasterLogBook {
  final String? message;
  final int? count;
  final List<DataMaster>? dataMaster;

  ModelMasterLogBook({
    this.message,
    this.count,
    this.dataMaster,
  });

  factory ModelMasterLogBook.fromJson(Map<String, dynamic> json) => ModelMasterLogBook(
        message: json["message"],
        count: json["count"],
        dataMaster: json["data"] == null ? [] : List<DataMaster>.from(json["data"]!.map((x) => DataMaster.fromJson(x))),
      );
}

class DataMaster {
  final int? id;
  final int? idJabatan;
  final String? kategori;
  final String? namaLog;
  final Jabatan? jabatan;

  DataMaster({
    this.id,
    this.idJabatan,
    this.kategori,
    this.namaLog,
    this.jabatan,
  });

  factory DataMaster.fromJson(Map<String, dynamic> json) => DataMaster(
        id: json["id"] ?? 0,
        idJabatan: json["id_jabatan"] ?? 0,
        kategori: json["kategori"] ?? "",
        namaLog: json["nama_log"] ?? "",
        jabatan: json["jabatan"] == null ? Jabatan.fromJson({}) : Jabatan.fromJson(json["jabatan"]),
      );
}

class Jabatan {
  final int? id;
  final String? kode;
  final String? namaJabatan;
  final String? keterangan;
  final int? potonganTelat;

  Jabatan({
    this.id,
    this.kode,
    this.namaJabatan,
    this.keterangan,
    this.potonganTelat,
  });

  factory Jabatan.fromJson(Map<String, dynamic> json) => Jabatan(
        id: json["id"] ?? 0,
        kode: json["kode"] ?? "",
        namaJabatan: json["nama_jabatan"] ?? "",
        keterangan: json["keterangan"] ?? "",
        potonganTelat: json["potongan_telat"] ?? 0,
      );
}
