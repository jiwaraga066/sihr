import 'dart:convert';

ModelLogBookPerawat modelLogBookPerawatFromJson(String str) => ModelLogBookPerawat.fromJson(json.decode(str));

class ModelLogBookPerawat {
  final String? message;
  final int? count;
  final List<DataLogbook>? dataLogbook;

  ModelLogBookPerawat({
    this.message,
    this.count,
    this.dataLogbook,
  });

  factory ModelLogBookPerawat.fromJson(Map<String, dynamic> json) => ModelLogBookPerawat(
        message: json["message"],
        count: json["count"],
        dataLogbook: json["data"] == null ? [] : List<DataLogbook>.from(json["data"]!.map((x) => DataLogbook.fromJson(x))),
      );
}

class DataLogbook {
  final int? id;
  final int? idPegawai;
  final int? idMLogbook;
  final int? status;
  final DateTime? tanggal;
  final String? jumlah;
  final String? keterangan;
  final String? jenis;
  final Pegawai? pegawai;
  final Mlogbook? mlogbook;

  DataLogbook({
    this.id,
    this.idPegawai,
    this.idMLogbook,
    this.status,
    this.tanggal,
    this.jenis,
    this.jumlah,
    this.keterangan,
    this.pegawai,
    this.mlogbook,
  });

  factory DataLogbook.fromJson(Map<String, dynamic> json) => DataLogbook(
        id: json["id"],
        idPegawai: json["id_pegawai"],
        idMLogbook: json["id_m_logbook"],
        status: json["status"] ?? 0,
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        jumlah: json["jumlah"] ?? "",
        jenis: json["jenis"] ?? "",
        keterangan: json["keterangan"] ?? "",
        pegawai: json["pegawai"] == null ? null : Pegawai.fromJson(json["pegawai"]),
        mlogbook: json["mlogbook"] == null ? null : Mlogbook.fromJson(json["mlogbook"]),
      );
}

class Mlogbook {
  final int? id;
  final int? idJabatan;
  final String? kategori;
  final String? namaLog;

  Mlogbook({
    this.id,
    this.idJabatan,
    this.kategori,
    this.namaLog,
  });

  factory Mlogbook.fromJson(Map<String, dynamic> json) => Mlogbook(
        id: json["id"],
        idJabatan: json["id_jabatan"],
        kategori: json["kategori"],
        namaLog: json["nama_log"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_jabatan": idJabatan,
        "kategori": kategori,
        "nama_log": namaLog,
      };
}

class Pegawai {
  final int? id;
  final String? nip;
  final String? noKtp;
  final String? nama;
  final String? tmptLahir;
  final DateTime? tglLahir;
  final String? jenisKelamin;
  final String? goldar;
  final String? agama;
  final String? alamat;
  final String? desa;
  final String? kecamatan;
  final String? kota;
  final String? propinsi;
  final DateTime? tglMasuk;
  final String? tentangKamu;
  final int? idGolongan;
  final int? idJabatan;
  final int? idDivisi;
  final int? idDepartement;
  final int? idUnit;
  final int? idBank;
  final String? noRek;
  final String? foto;
  final String? hp;
  final String? pendidikan;
  final String? prodi;
  final String? npwp;
  final String? statusMenikah;
  final int? statusKeluarga;
  final DateTime? tglResign;
  final String? ketResign;
  final int? statusResign;
  final String? nomr;
  final int? idKepalaBagian;
  final int? idUsers;

  Pegawai({
    this.id,
    this.nip,
    this.noKtp,
    this.nama,
    this.tmptLahir,
    this.tglLahir,
    this.jenisKelamin,
    this.goldar,
    this.agama,
    this.alamat,
    this.desa,
    this.kecamatan,
    this.kota,
    this.propinsi,
    this.tglMasuk,
    this.tentangKamu,
    this.idGolongan,
    this.idJabatan,
    this.idDivisi,
    this.idDepartement,
    this.idUnit,
    this.idBank,
    this.noRek,
    this.foto,
    this.hp,
    this.pendidikan,
    this.prodi,
    this.npwp,
    this.statusMenikah,
    this.statusKeluarga,
    this.tglResign,
    this.ketResign,
    this.statusResign,
    this.nomr,
    this.idKepalaBagian,
    this.idUsers,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
        id: json["id"] ?? 0,
        nip: json["nip"] ?? "",
        noKtp: json["no_ktp"] ?? '',
        nama: json["nama"] ?? '',
        tmptLahir: json["tmpt_lahir"] ?? "",
        tglLahir: json["tgl_lahir"] == null ? null : DateTime.parse(json["tgl_lahir"]),
        jenisKelamin: json["jenis_kelamin"] ?? "",
        goldar: json["goldar"] ?? "",
        agama: json["agama"] ?? "",
        alamat: json["alamat"] ?? "",
        desa: json["desa"] ?? "",
        kecamatan: json["kecamatan"] ?? "",
        kota: json["kota"] ?? "",
        propinsi: json["propinsi"] ?? "",
        tglMasuk: json["tgl_masuk"] == null ? null : DateTime.parse(json["tgl_masuk"]),
        tentangKamu: json["tentang_kamu"] ?? "",
        idGolongan: json["id_golongan"] ?? 0,
        idJabatan: json["id_jabatan"] ?? 0,
        idDivisi: json["id_divisi"] ?? 0,
        idDepartement: json["id_departement"] ?? 0,
        idUnit: json["id_unit"] ?? 0,
        idBank: json["id_bank"] ?? 0,
        noRek: json["no_rek"] ?? "",
        foto: json["foto"] ?? "",
        hp: json["hp"] ?? "",
        pendidikan: json["pendidikan"] ?? "",
        prodi: json["prodi"] ?? "",
        npwp: json["npwp"] ?? "",
        statusMenikah: json["status_menikah"] ?? "",
        statusKeluarga: json["status_keluarga"] ?? 0,
        tglResign: json["tgl_resign"] == null ? null : DateTime.parse(json["tgl_masuk"]),
        ketResign: json["ket_resign"] ?? "",
        statusResign: json["status_resign"] ?? 0,
        nomr: json["nomr"] ?? "",
        idKepalaBagian: json["id_kepala_bagian"] ?? 0,
        idUsers: json["id_users"] ?? 0,
      );
}
