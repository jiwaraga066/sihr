import 'dart:convert';

ModelLogBook modelLogBookFromJson(String str) => ModelLogBook.fromJson(json.decode(str));

class ModelLogBook {
  final String? message;
  final int? count;
  final List<DataLogBook>? dataLogBook;

  ModelLogBook({
    this.message,
    this.count,
    this.dataLogBook,
  });

  factory ModelLogBook.fromJson(Map<String, dynamic> json) => ModelLogBook(
        message: json["message"],
        count: json["count"],
        dataLogBook: json["data"] == null ? [] : List<DataLogBook>.from(json["data"]!.map((x) => DataLogBook.fromJson(x))),
      );
}

class DataLogBook {
  final int? id;
  final int? idPegawai;
  final String? namaLog;
  final DateTime? tanggal;
  final String? keterangan;
  final String? upload;
  final Pegawai? pegawai;

  DataLogBook({
    this.id,
    this.idPegawai,
    this.namaLog,
    this.tanggal,
    this.keterangan,
    this.upload,
    this.pegawai,
  });

  factory DataLogBook.fromJson(Map<String, dynamic> json) => DataLogBook(
        id: json["id"],
        idPegawai: json["id_pegawai"],
        namaLog: json["nama_log"],
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        keterangan: json["keterangan"],
        upload: json["upload"],
        pegawai: json["pegawai"] == null ? null : Pegawai.fromJson(json["pegawai"]),
      );
}

class Pegawai {
  final int? id;
  final String? nip;
  final String? noKtp;
  final String? nama;
  final String? tmptLahir;
  final String? tglLahir;
  final String? jenisKelamin;
  final String? goldar;
  final String? agama;
  final String? alamat;
  final String? desa;
  final String? kecamatan;
  final String? kota;
  final String? propinsi;
  final String? tglMasuk;
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
  final String? tglResign;
  final String? ketResign;
  final int? statusResign;
  final String? nomr;
  final int? idKepalaBagian;
  final int? idUsers;
  final int? jatahCuti;

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
    this.jatahCuti,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
        id: json["id"],
        nip: json["nip"],
        noKtp: json["no_ktp"],
        nama: json["nama"],
        tmptLahir: json["tmpt_lahir"],
        tglLahir: json["tgl_lahir"] ?? "",
        jenisKelamin: json["jenis_kelamin"],
        goldar: json["goldar"],
        agama: json["agama"],
        alamat: json["alamat"],
        desa: json["desa"],
        kecamatan: json["kecamatan"],
        kota: json["kota"] ?? "",
        propinsi: json["propinsi"] ?? "",
        tglMasuk: json["tgl_masuk"] ?? "",
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
        tglResign: json["tgl_resign"] ?? "",
        ketResign: json["ket_resign"] ?? "",
        statusResign: json["status_resign"] ?? 0,
        nomr: json["nomr"] ?? "",
        idKepalaBagian: json["id_kepala_bagian"] ?? 0,
        idUsers: json["id_users"] ?? 0,
        jatahCuti: json["jatah_cuti"] ?? 0,
      );
}
