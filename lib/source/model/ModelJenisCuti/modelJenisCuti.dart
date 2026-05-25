// To parse this JSON data, do
//
//     final modelJenisCuti = modelJenisCutiFromJson(jsonString);

import 'dart:convert';

ModelJenisCuti modelJenisCutiFromJson(String str) => ModelJenisCuti.fromJson(json.decode(str));

String modelJenisCutiToJson(ModelJenisCuti data) => json.encode(data.toJson());

class ModelJenisCuti {
    final String? message;
    final int? count;
    final List<DataCuti>? data;

    ModelJenisCuti({
        this.message,
        this.count,
        this.data,
    });

    factory ModelJenisCuti.fromJson(Map<String, dynamic> json) => ModelJenisCuti(
        message: json["message"],
        count: json["count"],
        data: json["data"] == null ? [] : List<DataCuti>.from(json["data"]!.map((x) => DataCuti.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataCuti {
    final int? id;
    final String? namaCuti;
    final int? jatah;
    final String? keterangan;
    final String? createdBy;
    final int? isDelete;

    DataCuti({
        this.id,
        this.namaCuti,
        this.jatah,
        this.keterangan,
        this.createdBy,
        this.isDelete,
    });

    factory DataCuti.fromJson(Map<String, dynamic> json) => DataCuti(
        id: json["id"],
        namaCuti: json["nama_cuti"] ?? "",
        jatah: json["jatah"] ?? "",
        keterangan: json["keterangan"] ?? "",
        createdBy: json["created_by"],
        isDelete: json["is_delete"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_cuti": namaCuti,
        "jatah": jatah,
        "keterangan": keterangan,
        "created_by": createdBy,
        "is_delete": isDelete,
    };
}
