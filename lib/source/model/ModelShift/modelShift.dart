// To parse this JSON data, do
//
//     final modelShift = modelShiftFromJson(jsonString);

import 'dart:convert';

ModelShift modelShiftFromJson(String str) => ModelShift.fromJson(json.decode(str));

String modelShiftToJson(ModelShift data) => json.encode(data.toJson());

class ModelShift {
    final String? message;
    final Data? data;

    ModelShift({
        this.message,
        this.data,
    });

    factory ModelShift.fromJson(Map<String, dynamic> json) => ModelShift(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final int? id;
    final String? namaShift;
    final String? jamMulai;
    final String? jamSelesai;
    final String? createdAt;
    final String? updatedAt;
    final int? isDelete;

    Data({
        this.id,
        this.namaShift,
        this.jamMulai,
        this.jamSelesai,
        this.createdAt,
        this.updatedAt,
        this.isDelete,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        namaShift: json["nama_shift"],
        jamMulai:   json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isDelete: json["is_delete"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_shift": namaShift,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_delete": isDelete,
    };
}
