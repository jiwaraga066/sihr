// To parse this JSON data, do
//
//     final modelJenisAbsen = modelJenisAbsenFromJson(jsonString);

import 'dart:convert';

ModelJenisAbsen modelJenisAbsenFromJson(String str) => ModelJenisAbsen.fromJson(json.decode(str));

String modelJenisAbsenToJson(ModelJenisAbsen data) => json.encode(data.toJson());

class ModelJenisAbsen {
    final String? message;
    final int? count;
    final List<Data>? data;

    ModelJenisAbsen({
        this.message,
        this.count,
        this.data,
    });

    factory ModelJenisAbsen.fromJson(Map<String, dynamic> json) => ModelJenisAbsen(
        message: json["message"],
        count: json["count"],
        data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Data {
    final int? id;
    final String? namaAbsen;
    final String? keterangan;
    final String? createdBy;
    final String? updatedBy;

    Data({
        this.id,
        this.namaAbsen,
        this.keterangan,
        this.createdBy,
        this.updatedBy,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        namaAbsen: json["nama_absen"] ?? "",
        keterangan: json["keterangan"] ?? "",
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_absen": namaAbsen,
        "keterangan": keterangan,
        "created_by": createdBy,
        "updated_by": updatedBy,
    };
}
