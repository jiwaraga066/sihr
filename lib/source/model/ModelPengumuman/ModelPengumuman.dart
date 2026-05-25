// To parse this JSON data, do
//
//     final modelPengumuman = modelPengumumanFromJson(jsonString);

import 'dart:convert';

ModelPengumuman modelPengumumanFromJson(String str) => ModelPengumuman.fromJson(json.decode(str));

String modelPengumumanToJson(ModelPengumuman data) => json.encode(data.toJson());

class ModelPengumuman {
    final String? message;
    final int? count;
    final List<DataPengumuman>? dataPengumuman;

    ModelPengumuman({
        this.message,
        this.count,
        this.dataPengumuman,
    });

    factory ModelPengumuman.fromJson(Map<String, dynamic> json) => ModelPengumuman(
        message: json["message"],
        count: json["count"],
        dataPengumuman: json["data"] == null ? [] : List<DataPengumuman>.from(json["data"]!.map((x) => DataPengumuman.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "data": dataPengumuman == null ? [] : List<dynamic>.from(dataPengumuman!.map((x) => x.toJson())),
    };
}

class DataPengumuman {
    final int? id;
    final int? idJenisPengumuman;
    final String? namaPengumuman;
    final String? isi;
    final DateTime? tanggal;
    final String? tipe;
    final Jenis? jenis;

    DataPengumuman({
        this.id,
        this.idJenisPengumuman,
        this.namaPengumuman,
        this.isi,
        this.tanggal,
        this.tipe,
        this.jenis,
    });

    factory DataPengumuman.fromJson(Map<String, dynamic> json) => DataPengumuman(
        id: json["id"],
        idJenisPengumuman: json["id_jenis_pengumuman"],
        namaPengumuman: json["nama_pengumuman"],
        isi: json["isi"],
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        tipe: json["tipe"],
        jenis: json["jenis"] == null ? null : Jenis.fromJson(json["jenis"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_jenis_pengumuman": idJenisPengumuman,
        "nama_pengumuman": namaPengumuman,
        "isi": isi,
        "tanggal": "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "tipe": tipe,
        "jenis": jenis?.toJson(),
    };
}

class Jenis {
    final int? id;
    final String? namaJenis;
    final String? keterangan;
    final int? status;

    Jenis({
        this.id,
        this.namaJenis,
        this.keterangan,
        this.status,
    });

    factory Jenis.fromJson(Map<String, dynamic> json) => Jenis(
        id: json["id"],
        namaJenis: json["nama_jenis"],
        keterangan: json["keterangan"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_jenis": namaJenis,
        "keterangan": keterangan,
        "status": status,
    };
}
