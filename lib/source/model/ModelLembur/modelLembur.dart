// To parse this JSON data, do
//
//     final modelLembur = modelLemburFromJson(jsonString);

import 'dart:convert';

ModelLembur modelLemburFromJson(String str) => ModelLembur.fromJson(json.decode(str));

String modelLemburToJson(ModelLembur data) => json.encode(data.toJson());

class ModelLembur {
  final String? message;
  final int? count;
  final List<Datum>? data;

  ModelLembur({
    this.message,
    this.count,
    this.data,
  });

  factory ModelLembur.fromJson(Map<String, dynamic> json) => ModelLembur(
        message: json["message"],
        count: json["count"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final int? id;
  final int? idPegawai;
  final DateTime? tanggal;
  final String? jamMulai;
  final String? jamSelesai;
  final String? jumlahJam;
  final String? jumlahJamAcc;
  final int? nilai;
  final String? keterangan;
  final String? noreff;
  final int? status;
  final String? jenis;
  final String? kategori;
  final String? feedback;
  final DateTime? tglAcc;
  final int? userAcc;
  final Pegawai? pegawai;

  Datum({
    this.id,
    this.idPegawai,
    this.tanggal,
    this.jamMulai,
    this.jamSelesai,
    this.jumlahJam,
    this.jumlahJamAcc,
    this.nilai,
    this.keterangan,
    this.noreff,
    this.status,
    this.jenis,
    this.kategori,
    this.feedback,
    this.tglAcc,
    this.userAcc,
    this.pegawai,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idPegawai: json["id_pegawai"],
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        jamMulai: json["jam_mulai"] ?? "",
        jamSelesai: json["jam_selesai"] ?? "",
        jumlahJam: json["jumlah_jam"]?? "",
        jumlahJamAcc: json["jumlah_jam_acc"]?? "",
        nilai: json["nilai"] ?? 0,
        keterangan: json["keterangan"] ?? "",
        noreff: json["noreff"] ?? "",
        status: json["status"] ?? 0,
        jenis: json["jenis"] ?? "",
        kategori: json["kategori"] ?? "",
        feedback: json["feedback"] ?? "",
        tglAcc: json["tgl_acc"] == null ? null : DateTime.parse(json["tgl_acc"]),
        userAcc: json["user_acc"],
        pegawai: json["pegawai"] == null ? null : Pegawai.fromJson(json["pegawai"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pegawai": idPegawai,
        "tanggal": "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "jumlah_jam": jumlahJam,
        "jumlah_jam_acc": jumlahJamAcc,
        "nilai": nilai,
        "keterangan": keterangan,
        "noreff": noreff,
        "status": status,
        "jenis": jenis,
        "kategori": kategori,
        "feedback": feedback,
        "tgl_acc": "${tglAcc!.year.toString().padLeft(4, '0')}-${tglAcc!.month.toString().padLeft(2, '0')}-${tglAcc!.day.toString().padLeft(2, '0')}",
        "user_acc": userAcc,
        "pegawai": pegawai?.toJson(),
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
  final int? jatahCuti;
  final Jabatan? jabatan;
  final Divisi? divisi;

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
    this.jabatan,
    this.divisi,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
        id: json["id"] ?? 0,
        nip: json["nip"] ?? "",
        noKtp: json["no_ktp"] ?? "",
        nama: json["nama"] ?? "",
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
        tglResign: json["tgl_resign"] == null ? null : DateTime.parse(json["tgl_resign"]),
        ketResign: json["ket_resign"]?? "",
        statusResign: json["status_resign"] ?? 0,
        nomr: json["nomr"] ?? "",
        idKepalaBagian: json["id_kepala_bagian"] ?? 0,
        idUsers: json["id_users"] ?? 0,
        jatahCuti: json["jatah_cuti"] ?? 0,
        jabatan: json["jabatan"] == null ? null : Jabatan.fromJson(json["jabatan"]),
        divisi: json["divisi"] == null ? null : Divisi.fromJson(json["divisi"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nip": nip,
        "no_ktp": noKtp,
        "nama": nama,
        "tmpt_lahir": tmptLahir,
        "tgl_lahir": "${tglLahir!.year.toString().padLeft(4, '0')}-${tglLahir!.month.toString().padLeft(2, '0')}-${tglLahir!.day.toString().padLeft(2, '0')}",
        "jenis_kelamin": jenisKelamin,
        "goldar": goldar,
        "agama": agama,
        "alamat": alamat,
        "desa": desa,
        "kecamatan": kecamatan,
        "kota": kota,
        "propinsi": propinsi,
        "tgl_masuk": "${tglMasuk!.year.toString().padLeft(4, '0')}-${tglMasuk!.month.toString().padLeft(2, '0')}-${tglMasuk!.day.toString().padLeft(2, '0')}",
        "tentang_kamu": tentangKamu,
        "id_golongan": idGolongan,
        "id_jabatan": idJabatan,
        "id_divisi": idDivisi,
        "id_departement": idDepartement,
        "id_unit": idUnit,
        "id_bank": idBank,
        "no_rek": noRek,
        "foto": foto,
        "hp": hp,
        "pendidikan": pendidikan,
        "prodi": prodi,
        "npwp": npwp,
        "status_menikah": statusMenikah,
        "status_keluarga": statusKeluarga,
        "tgl_resign":
            "${tglResign!.year.toString().padLeft(4, '0')}-${tglResign!.month.toString().padLeft(2, '0')}-${tglResign!.day.toString().padLeft(2, '0')}",
        "ket_resign": ketResign,
        "status_resign": statusResign,
        "nomr": nomr,
        "id_kepala_bagian": idKepalaBagian,
        "id_users": idUsers,
        "jatah_cuti": jatahCuti,
        "jabatan": jabatan?.toJson(),
        "divisi": divisi?.toJson(),
      };
}

class Divisi {
  final int? id;
  final String? namaDivisi;
  final String? keterangan;

  Divisi({
    this.id,
    this.namaDivisi,
    this.keterangan,
  });

  factory Divisi.fromJson(Map<String, dynamic> json) => Divisi(
        id: json["id"] ?? 0,
        namaDivisi: json["nama_divisi"] ?? "",
        keterangan: json["keterangan"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_divisi": namaDivisi,
        "keterangan": keterangan,
      };
}

class Jabatan {
  final int? id;
  final String? kode;
  final String? namaJabatan;
  final String? keterangan;
  final int? potonganTelat;

  Jabatan({
    this.id,
    this.kode,
    this.namaJabatan,
    this.keterangan,
    this.potonganTelat,
  });

  factory Jabatan.fromJson(Map<String, dynamic> json) => Jabatan(
        id: json["id"] ?? 0,
        kode: json["kode"] ?? "",
        namaJabatan: json["nama_jabatan"] ?? "",
        keterangan: json["keterangan"] ?? "",
        potonganTelat: json["potongan_telat"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nama_jabatan": namaJabatan,
        "keterangan": keterangan,
        "potongan_telat": potonganTelat,
      };
}
