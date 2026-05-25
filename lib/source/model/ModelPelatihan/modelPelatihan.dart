// To parse this JSON data, do
//
//     final modelPelatihan = modelPelatihanFromJson(jsonString);

import 'dart:convert';

ModelPelatihan modelPelatihanFromJson(String str) => ModelPelatihan.fromJson(json.decode(str));

String modelPelatihanToJson(ModelPelatihan data) => json.encode(data.toJson());

class ModelPelatihan {
  final String? message;
  final int? count;
  final List<DataPelatihan>? dataPelatihan;

  ModelPelatihan({
    this.message,
    this.count,
    this.dataPelatihan,
  });

  factory ModelPelatihan.fromJson(Map<String, dynamic> json) => ModelPelatihan(
        message: json["message"],
        count: json["count"],
        dataPelatihan: json["data"] == null ? [] : List<DataPelatihan>.from(json["data"]!.map((x) => DataPelatihan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "data": dataPelatihan == null ? [] : List<dynamic>.from(dataPelatihan!.map((x) => x.toJson())),
      };
}

class DataPelatihan {
  final int? id;
  final int? idPegawai;
  final int? idPelatihan;
  final String? status;
  final String? resume;
  final String? foto;
  final String? latt;
  final String? att;
  final Pelatihan? pelatihan;
  final Pegawai? pegawai;
  DataPelatihan(
      {required this.id,
      required this.idPegawai,
      required this.idPelatihan,
      required this.status,
      required this.resume,
      required this.foto,
      required this.latt,
      required this.att,
      required this.pelatihan,
      required this.pegawai});
  factory DataPelatihan.fromJson(Map<String, dynamic> json) => DataPelatihan(
        id: json["id"],
        idPegawai: json["id_pegawai"] ?? 0,
        idPelatihan: json["id_pelatihan"] ?? 0,
        status: json["status"] ?? "",
        resume: json["resume"] ?? "",
        foto: json["foto"] ?? "",
        latt: json["latt"] ?? "",
        att: json["att"] ?? "",
        
        pelatihan: json["pelatihan"] == null ? null : Pelatihan.fromJson(json["pelatihan"]),
        pegawai: json["pegawai"] == null ? null : Pegawai.fromJson(json["pegawai"]),
      );



  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pegawai": idPegawai,
        "id_pelatihan": idPelatihan,
        "status": status,
        "pelatihan": pelatihan?.toJson(),
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
  final String? tglResign;
  final String? ketResign;
  final int? statusResign;
  final String? nomr;
  final int? idKepalaBagian;
  final int? idUsers;
  final int? jatahCuti;
  final Golongan? golongan;
  final Jabatan? jabatan;

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
    this.golongan,
    this.jabatan,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
        id: json["id"],
        nip: json["nip"],
        noKtp: json["no_ktp"],
        nama: json["nama"],
        tmptLahir: json["tmpt_lahir"],
        tglLahir: json["tgl_lahir"] == null ? null : DateTime.parse(json["tgl_lahir"]),
        jenisKelamin: json["jenis_kelamin"],
        goldar: json["goldar"],
        agama: json["agama"],
        alamat: json["alamat"],
        desa: json["desa"],
        kecamatan: json["kecamatan"],
        kota: json["kota"],
        propinsi: json["propinsi"],
        tglMasuk: json["tgl_masuk"] == null ? null : DateTime.parse(json["tgl_masuk"]),
        tentangKamu: json["tentang_kamu"],
        idGolongan: json["id_golongan"],
        idJabatan: json["id_jabatan"],
        idDivisi: json["id_divisi"],
        idDepartement: json["id_departement"],
        idUnit: json["id_unit"],
        idBank: json["id_bank"],
        noRek: json["no_rek"],
        foto: json["foto"],
        hp: json["hp"],
        pendidikan: json["pendidikan"],
        prodi: json["prodi"],
        npwp: json["npwp"],
        statusMenikah: json["status_menikah"],
        statusKeluarga: json["status_keluarga"],
        tglResign: json["tgl_resign"],
        ketResign: json["ket_resign"],
        statusResign: json["status_resign"],
        nomr: json["nomr"],
        idKepalaBagian: json["id_kepala_bagian"],
        idUsers: json["id_users"],
        jatahCuti: json["jatah_cuti"],
        golongan: json["golongan"] == null ? null : Golongan.fromJson(json["golongan"]),
        jabatan: json["jabatan"] == null ? null : Jabatan.fromJson(json["jabatan"]),
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
        "tgl_resign": tglResign,
        "ket_resign": ketResign,
        "status_resign": statusResign,
        "nomr": nomr,
        "id_kepala_bagian": idKepalaBagian,
        "id_users": idUsers,
        "jatah_cuti": jatahCuti,
        "golongan": golongan?.toJson(),
        "jabatan": jabatan?.toJson(),
      };
}

class Golongan {
  final int? id;
  final String? namaGolongan;
  final String? keterangan;

  Golongan({
    this.id,
    this.namaGolongan,
    this.keterangan,
  });

  factory Golongan.fromJson(Map<String, dynamic> json) => Golongan(
        id: json["id"],
        namaGolongan: json["nama_golongan"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_golongan": namaGolongan,
        "keterangan": keterangan,
      };
}

class Jabatan {
  final int? id;
  final String? kode;
  final String? namaJabatan;
  final String? keterangan;

  Jabatan({
    this.id,
    this.kode,
    this.namaJabatan,
    this.keterangan,
  });

  factory Jabatan.fromJson(Map<String, dynamic> json) => Jabatan(
        id: json["id"],
        kode: json["kode"],
        namaJabatan: json["nama_jabatan"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nama_jabatan": namaJabatan,
        "keterangan": keterangan,
      };
}

class Pelatihan {
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

  Pelatihan({
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

  factory Pelatihan.fromJson(Map<String, dynamic> json) => Pelatihan(
        id: json["id"],
        namaPelatihan: json["nama_pelatihan"] ?? "",
        tipe: json["tipe"] ?? "",
        penyelenggara: json["penyelenggara"] ?? "",
        deskripsi: json["deskripsi"] ?? "",
        idJenisPelatihan: json["id_jenis_pelatihan"] ?? 0,
        tanggalMulai: json["tanggal_mulai"] == null ? null : DateTime.parse(json["tanggal_mulai"]),
        jamMulai: json["jam_mulai"],
        tanggalSelesai: json["tanggal_selesai"] == null ? null : DateTime.parse(json["tanggal_selesai"]),
        jamSelesai: json["jam_selesai"],
        tempat: json["tempat"] ?? "",
        jumlahJam: json["jumlah_jam"] ?? "",
        jumlahSkp: json["jumlah_skp"] ?? 0,
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
