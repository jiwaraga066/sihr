
import 'dart:convert';

ModelKategoriPelatihan modelKategoriPelatihanFromJson(String str) => ModelKategoriPelatihan.fromJson(json.decode(str));

String modelKategoriPelatihanToJson(ModelKategoriPelatihan data) => json.encode(data.toJson());

class ModelKategoriPelatihan {
  final String? message;
  final int? count;
  final List<DataKategori>? dataKategori;

  ModelKategoriPelatihan({
    this.message,
    this.count,
    this.dataKategori,
  });

  factory ModelKategoriPelatihan.fromJson(Map<String, dynamic> json) => ModelKategoriPelatihan(
        message: json["message"],
        count: json["count"],
        dataKategori: json["data"] == null ? [] : List<DataKategori>.from(json["data"]!.map((x) => DataKategori.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "data_kategori": dataKategori == null ? [] : List<dynamic>.from(dataKategori!.map((x) => x.toJson())),
      };
}

class DataKategori {
  final int? id;
  final String? namaPelatihan;
  final String? tipe;
  final String? penyelenggara;
  final String? deskripsi;
  final int? idJenisPelatihan;
  final DateTime? tanggalMulai;
  final String? jamMulai;
  final DateTime? tanggalSelesai;
  final String? jamSelesai;
  final String? tempat;
  final String? jumlahJam;
  final int? jumlahSkp;
  final Jenispelatihan? jenispelatihan;

  DataKategori({
    this.id,
    this.namaPelatihan,
    this.tipe,
    this.penyelenggara,
    this.deskripsi,
    this.idJenisPelatihan,
    this.tanggalMulai,
    this.jamMulai,
    this.tanggalSelesai,
    this.jamSelesai,
    this.tempat,
    this.jumlahJam,
    this.jumlahSkp,
    this.jenispelatihan,
  });

  factory DataKategori.fromJson(Map<String, dynamic> json) => DataKategori(
        id: json["id"],
        namaPelatihan: json["nama_pelatihan"],
        tipe: json["tipe"],
        penyelenggara: json["penyelenggara"],
        deskripsi: json["deskripsi"],
        idJenisPelatihan: json["id_jenis_pelatihan"],
        tanggalMulai: json["tanggal_mulai"] == null ? null : DateTime.parse(json["tanggal_mulai"]),
        jamMulai: json["jam_mulai"],
        tanggalSelesai: json["tanggal_selesai"] == null ? null : DateTime.parse(json["tanggal_selesai"]),
        jamSelesai: json["jam_selesai"],
        tempat: json["tempat"],
        jumlahJam: json["jumlah_jam"],
        jumlahSkp: json["jumlah_skp"],
        jenispelatihan: json["jenispelatihan"] == null ? null : Jenispelatihan.fromJson(json["jenispelatihan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_pelatihan": namaPelatihan,
        "tipe": tipe,
        "penyelenggara": penyelenggara,
        "deskripsi": deskripsi,
        "id_jenis_pelatihan": idJenisPelatihan,
        "tanggal_mulai":
            "${tanggalMulai!.year.toString().padLeft(4, '0')}-${tanggalMulai!.month.toString().padLeft(2, '0')}-${tanggalMulai!.day.toString().padLeft(2, '0')}",
        "jam_mulai": jamMulai,
        "tanggal_selesai":
            "${tanggalSelesai!.year.toString().padLeft(4, '0')}-${tanggalSelesai!.month.toString().padLeft(2, '0')}-${tanggalSelesai!.day.toString().padLeft(2, '0')}",
        "jam_selesai": jamSelesai,
        "tempat": tempat,
        "jumlah_jam": jumlahJam,
        "jumlah_skp": jumlahSkp,
        "jenispelatihan": jenispelatihan?.toJson(),
      };
}

class Jenispelatihan {
  final int? id;
  final String? namaJenis;
  final String? keterangan;

  Jenispelatihan({
    this.id,
    this.namaJenis,
    this.keterangan,
  });

  factory Jenispelatihan.fromJson(Map<String, dynamic> json) => Jenispelatihan(
        id: json["id"],
        namaJenis: json["nama_jenis"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_jenis": namaJenis,
        "keterangan": keterangan,
      };
}
