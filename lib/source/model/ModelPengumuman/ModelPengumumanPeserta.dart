import 'dart:convert';

ModelPengumumanPeserta modelPengumumanPesertaFromJson(String str) => ModelPengumumanPeserta.fromJson(json.decode(str));

class ModelPengumumanPeserta {
  final String? message;
  final int? count;
  final List<Datum>? data;

  ModelPengumumanPeserta({
    this.message,
    this.count,
    this.data,
  });

  factory ModelPengumumanPeserta.fromJson(Map<String, dynamic> json) => ModelPengumumanPeserta(
        message: json["message"],
        count: json["count"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  final int? id;
  final int? idPegawai;
  final int? idPengumuman;
  final String? cekin;
  final String? resume;
  final Pegawai? pegawai;
  final Pengumuman? pengumuman;

  Datum({
    this.id,
    this.idPegawai,
    this.idPengumuman,
    this.cekin,
    this.resume,
    this.pegawai,
    this.pengumuman,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idPegawai: json["id_pegawai"],
        idPengumuman: json["id_pengumuman"],
        cekin: json["cekin"] ?? "",
        resume: json["resume"] ?? "",
        pegawai: json["pegawai"] == null ? null : Pegawai.fromJson(json["pegawai"]),
        pengumuman: json["pengumuman"] == null ? null : Pengumuman.fromJson(json["pengumuman"]),
      );
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
  final Golongan? golongan;

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
    this.golongan,
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
        tglResign: json["tgl_resign"] == null ? null : DateTime.parse(json["tgl_resign"]),
        ketResign: json["ket_resign"],
        statusResign: json["status_resign"],
        nomr: json["nomr"],
        idKepalaBagian: json["id_kepala_bagian"],
        idUsers: json["id_users"],
        jatahCuti: json["jatah_cuti"],
        jabatan: json["jabatan"] == null ? null : Jabatan.fromJson(json["jabatan"]),
        golongan: json["golongan"] == null ? null : Golongan.fromJson(json["golongan"]),
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
        "golongan": golongan?.toJson(),
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

class Pengumuman {
  final int? id;
  final int? idJenisPengumuman;
  final String? namaPengumuman;
  final String? isi;
  final DateTime? tanggal;
  final String? tipe;

  Pengumuman({
    this.id,
    this.idJenisPengumuman,
    this.namaPengumuman,
    this.isi,
    this.tanggal,
    this.tipe,
  });

  factory Pengumuman.fromJson(Map<String, dynamic> json) => Pengumuman(
        id: json["id"],
        idJenisPengumuman: json["id_jenis_pengumuman"],
        namaPengumuman: json["nama_pengumuman"],
        isi: json["isi"],
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        tipe: json["tipe"],
      );
}
