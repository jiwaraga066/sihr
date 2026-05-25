// To parse this JSON data, do
//
//     final modelJenisizin = modelJenisizinFromJson(jsonString);

import 'dart:convert';

ModelJenisizin modelJenisizinFromJson(String str) => ModelJenisizin.fromJson(json.decode(str));

String modelJenisizinToJson(ModelJenisizin data) => json.encode(data.toJson());

class ModelJenisizin {
    final String? message;
    final int? count;
    final List<Dataizin>? data;

    ModelJenisizin({
        this.message,
        this.count,
        this.data,
    });

    factory ModelJenisizin.fromJson(Map<String, dynamic> json) => ModelJenisizin(
        message: json["message"],
        count: json["count"],
        data: json["data"] == null ? [] : List<Dataizin>.from(json["data"]!.map((x) => Dataizin.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Dataizin {
    final int? id;
    final String? namaIzin;
    final String? keterangan;
    final String? createdBy;
    final int? isDelete;

    Dataizin({
        this.id,
        this.namaIzin,
        this.keterangan,
        this.createdBy,
        this.isDelete,
    });

    factory Dataizin.fromJson(Map<String, dynamic> json) => Dataizin(
        id: json["id"],
        namaIzin: json["nama_izin"] ?? "",
        keterangan: json["keterangan"] ?? "",
        createdBy: json["created_by"],
        isDelete: json["is_delete"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_izin": namaIzin,
        "keterangan": keterangan,
        "created_by": createdBy,
        "is_delete": isDelete,
    };
}
