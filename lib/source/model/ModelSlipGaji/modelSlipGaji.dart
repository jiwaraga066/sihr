// To parse this JSON data, do
//
//     final modelSlipGaji = modelSlipGajiFromJson(jsonString);

import 'dart:convert';

ModelSlipGaji modelSlipGajiFromJson(String str) => ModelSlipGaji.fromJson(json.decode(str));

String modelSlipGajiToJson(ModelSlipGaji data) => json.encode(data.toJson());

class ModelSlipGaji {
  final String? message;
  final int? count;
  final List<DataSlipgaji>? dataSlipgaji;

  ModelSlipGaji({
    this.message,
    this.count,
    this.dataSlipgaji,
  });

  factory ModelSlipGaji.fromJson(Map<String, dynamic> json) => ModelSlipGaji(
        message: json["message"],
        count: json["count"],
        dataSlipgaji: json["data"] == null ? [] : List<DataSlipgaji>.from(json["data"]!.map((x) => DataSlipgaji.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "data": dataSlipgaji == null ? [] : List<dynamic>.from(dataSlipgaji!.map((x) => x.toJson())),
      };
}

class DataSlipgaji {
  final int? id;
  final int? idPegawai;
  final String? noreff;
  final String? bulan;
  final int? tahun;
  final int? pendapatan;
  final int? potongan;
  final Pegawai? pegawai;

  DataSlipgaji({
    this.id,
    this.idPegawai,
    this.noreff,
    this.bulan,
    this.tahun,
    this.pendapatan,
    this.potongan,
    this.pegawai,
  });

  factory DataSlipgaji.fromJson(Map<String, dynamic> json) => DataSlipgaji(
        id: json["id"],
        idPegawai: json["id_pegawai"],
        noreff: json["noreff"],
        bulan: json["bulan"],
        tahun: json["tahun"],
        pendapatan: json["pendapatan"],
        potongan: json["potongan"],
        pegawai: json["pegawai"] == null ? null : Pegawai.fromJson(json["pegawai"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pegawai": idPegawai,
        "noreff": noreff,
        "bulan": bulan,
        "tahun": tahun,
        "pendapatan": pendapatan,
        "potongan": potongan,
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
  final Divisi? divisi;
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
    this.divisi,
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
        prodi: json["prodi"] ?? "",
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
        divisi: json["divisi"] == null ? null : Divisi.fromJson(json["divisi"]),
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
        "divisi": divisi?.toJson(),
        "jabatan": jabatan?.toJson(),
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
        id: json["id"],
        namaDivisi: json["nama_divisi"],
        keterangan: json["keterangan"],
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
        id: json["id"],
        kode: json["kode"],
        namaJabatan: json["nama_jabatan"],
        keterangan: json["keterangan"],
        potonganTelat: json["potongan_telat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nama_jabatan": namaJabatan,
        "keterangan": keterangan,
        "potongan_telat": potonganTelat,
      };
}
