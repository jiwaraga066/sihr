
import 'dart:convert';

Modeljenispelatihan modeljenispelatihanFromJson(String str) => Modeljenispelatihan.fromJson(json.decode(str));

String modeljenispelatihanToJson(Modeljenispelatihan data) => json.encode(data.toJson());

class Modeljenispelatihan {
  final String? message;
  final int? count;
  final List<DataPelatihan>? dataPelatihan;

  Modeljenispelatihan({
    this.message,
    this.count,
    this.dataPelatihan,
  });

  factory Modeljenispelatihan.fromJson(Map<String, dynamic> json) => Modeljenispelatihan(
        message: json["message"],
        count: json["count"],
        dataPelatihan: json["data_pelatihan"] == null ? [] : List<DataPelatihan>.from(json["data_pelatihan"]!.map((x) => DataPelatihan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "data_pelatihan": dataPelatihan == null ? [] : List<dynamic>.from(dataPelatihan!.map((x) => x.toJson())),
      };
}

class DataPelatihan {
  final int? id;
  final String? namaJenis;
  final String? keterangan;

  DataPelatihan({
    this.id,
    this.namaJenis,
    this.keterangan,
  });

  factory DataPelatihan.fromJson(Map<String, dynamic> json) => DataPelatihan(
        id: json["id"],
        namaJenis: json["nama_jenis"] ?? "",
        keterangan: json["keterangan"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_jenis": namaJenis,
        "keterangan": keterangan,
      };
}
