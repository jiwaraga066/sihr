// To parse this JSON data, do
//
//     final modelDataAbsensi = modelDataAbsensiFromJson(jsonString);

import 'dart:convert';

ModelDataAbsensi modelDataAbsensiFromJson(String str) => ModelDataAbsensi.fromJson(json.decode(str));

String modelDataAbsensiToJson(ModelDataAbsensi data) => json.encode(data.toJson());

class ModelDataAbsensi {
  final String? message;
  final int? count;
  final List<Datauser>? data;

  ModelDataAbsensi({
    this.message,
    this.count,
    this.data,
  });

  factory ModelDataAbsensi.fromJson(Map<String, dynamic> json) => ModelDataAbsensi(
        message: json["message"],
        count: json["count"],
        data: json["data"] == null ? [] : List<Datauser>.from(json["data"]!.map((x) => Datauser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datauser {
  final int? id;
  final int? idPegawai;
  final int? idShift;
  final DateTime? tanggal;
  final String? waktuMasuk;
  final String? waktuKeluar;
  final int? status;
  final String? keterangan;
  final String? fotoUrl;
  final String? latt;
  final String? att;
  final int? terlambat;
  final String? nip;
  final String? namaPegawai;
  final String? jabatan;
  final String? divisi;
  final String? departement;
  final String? shift;
  final String? jenis;

  Datauser({
    this.nip,
    this.namaPegawai,
    this.jabatan,
    this.divisi,
    this.departement,
    this.shift,
    this.id,
    this.idPegawai,
    this.idShift,
    this.tanggal,
    this.waktuMasuk,
    this.waktuKeluar,
    this.status,
    this.keterangan,
    this.fotoUrl,
    this.latt,
    this.att,
    this.terlambat,
    this.jenis,
  });

  factory Datauser.fromJson(Map<String, dynamic> json) => Datauser(
        id: json["id"],
        idPegawai: json["id_pegawai"],
        idShift: json["id_shift"],
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        waktuMasuk: json["waktu_masuk"] ?? "",
        waktuKeluar: json["waktu_keluar"] ?? "",
        status: json["status"] ?? 0,
        keterangan: json["keterangan"] ?? "",
        jenis: json["jenis"] ?? "",
        fotoUrl: json["foto_url"] ?? "",
        latt: json["latt"] ?? "",
        att: json["att"] ?? "",
        terlambat: json["terlambat"] ?? 0,
        nip: json["nip"] ?? "",
        namaPegawai: json["nama_pegawai"] ?? "",
        jabatan: json["jabatan"] ?? "",
        divisi: json["divisi"] ?? "",
        departement: json["departement"] ?? "",
        shift: json["shift"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pegawai": idPegawai,
        "id_shift": idShift,
        "tanggal": "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "waktu_masuk": waktuMasuk,
        "waktu_keluar": waktuKeluar,
        "status": status,
        "keterangan": keterangan,
        "foto_url": fotoUrl,
        "latt": latt,
        "att": att,
        "terlambat": terlambat,
      };
}
