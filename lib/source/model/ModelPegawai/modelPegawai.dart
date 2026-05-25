// To parse this JSON data, do
//
//     final modelPegawai = modelPegawaiFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

ModelPegawai modelPegawaiFromJson(String str) => ModelPegawai.fromJson(json.decode(str));

String modelPegawaiToJson(ModelPegawai data) => json.encode(data.toJson());

class ModelPegawai {
    final String? message;
    final Data? data;
    final List<Jadwal>? jadwal;

    ModelPegawai({
        this.message,
        this.data,
        this.jadwal,
    });

    factory ModelPegawai.fromJson(Map<String, dynamic> json) => ModelPegawai(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        jadwal: json["jadwal"] == null ? [] : List<Jadwal>.from(json["jadwal"]!.map((x) => Jadwal.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "jadwal": jadwal == null ? [] : List<dynamic>.from(jadwal!.map((x) => x.toJson())),
    };
}

class Data {
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
    final dynamic tglResign;
    final dynamic ketResign;
    final int? statusResign;
    final dynamic nomr;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? idUsers;
    final int? idKepalaBagian;
    final String? createdBy;
    final String? updatedBy;
    final int? isDelete;
    final dynamic deletedAt;
    final dynamic deletedBy;
    final Bank? golongan;
    final Jabatan? jabatan;
    final Bank? divisi;
    final Bank? departement;
    final Bank? unit;
    final Bank? bank;
    final Users? users;


    Data({
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
        this.createdAt,
        this.updatedAt,
        this.idUsers,
        this.createdBy,
        this.updatedBy,
        this.isDelete,
        this.deletedAt,
        this.deletedBy,
        this.golongan,
        this.jabatan,
        this.divisi,
        this.departement,
        this.unit,
        this.bank,
        this.users,
        this.idKepalaBagian
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nip: json["nip"] ?? "",
        noKtp: json["no_ktp"] ?? "",
        nama: json["nama"] ?? "",
        tmptLahir: json["tmpt_lahir"] ?? "",
         tglLahir: json["tgl_lahir"] == null ? "" : DateFormat('dd MMM yyyy').format(DateTime.parse(json["tgl_lahir"])),
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
        statusKeluarga: json["status_keluarga"] ?? "",
        tglResign: json["tgl_resign"] ?? "",
        ketResign: json["ket_resign"] ?? "",
        statusResign: json["status_resign"] ?? 0,
        nomr: json["nomr"] ?? "",
        idKepalaBagian: json["id_kepala_bagian"] ?? 0,
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        idUsers: json["id_users"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        isDelete: json["is_delete"],
        deletedAt: json["deleted_at"],
        deletedBy: json["deleted_by"],
        golongan: json["golongan"] == null ? null : Bank.fromJson(json["golongan"]),
        jabatan: json["jabatan"] == null ? null : Jabatan.fromJson(json["jabatan"]),
        divisi: json["divisi"] == null ? null : Bank.fromJson(json["divisi"]),
        departement: json["departement"] == null ? null : Bank.fromJson(json["departement"]),
        unit: json["unit"] == null ? null : Bank.fromJson(json["unit"]),
        bank: json["bank"] == null ? null : Bank.fromJson(json["bank"]),
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nip": nip,
        "no_ktp": noKtp,
        "nama": nama,
        "tmpt_lahir": tmptLahir,
        // "tgl_lahir": "${tglLahir!.year.toString().padLeft(4, '0')}-${tglLahir!.month.toString().padLeft(2, '0')}-${tglLahir!.day.toString().padLeft(2, '0')}",
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id_users": idUsers,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "is_delete": isDelete,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy,
        "golongan": golongan?.toJson(),
        "jabatan": jabatan?.toJson(),
        "divisi": divisi?.toJson(),
        "departement": departement?.toJson(),
        "unit": unit?.toJson(),
        "bank": bank?.toJson(),
        "users": users?.toJson(),
    };
}

class Bank {
    final int? id;
    final String? namaBank;
    final String? keterangan;
    final String? createdBy;
    final String? updatedBy;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? isDelete;
    final dynamic deletedAt;
    final dynamic deletedBy;
    final int? idDivisi;
    final String? namaDepartemen;
    final String? namaDivisi;
    final String? namaGolongan;
    final int? idDepartemen;
    final String? namaUnit;

    Bank({
        this.id,
        this.namaBank,
        this.keterangan,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.isDelete,
        this.deletedAt,
        this.deletedBy,
        this.idDivisi,
        this.namaDepartemen,
        this.namaDivisi,
        this.namaGolongan,
        this.idDepartemen,
        this.namaUnit,
    });

    factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        namaBank: json["nama_bank"],
        keterangan: json["keterangan"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isDelete: json["is_delete"],
        deletedAt: json["deleted_at"],
        deletedBy: json["deleted_by"],
        idDivisi: json["id_divisi"],
        namaDepartemen: json["nama_departemen"],
        namaDivisi: json["nama_divisi"],
        namaGolongan: json["nama_golongan"],
        idDepartemen: json["id_departemen"],
        namaUnit: json["nama_unit"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_bank": namaBank,
        "keterangan": keterangan,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_delete": isDelete,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy,
        "id_divisi": idDivisi,
        "nama_departemen": namaDepartemen,
        "nama_divisi": namaDivisi,
        "nama_golongan": namaGolongan,
        "id_departemen": idDepartemen,
        "nama_unit": namaUnit,
    };
}

class Jabatan {
    final int? id;
    final String? kode;
    final int? jatahCutiTahunan;
    final String? namaJabatan;
    final String? keterangan;
    final int? potonganTelat;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic createdBy;
    final dynamic updatedBy;
    final int? isDelete;
    final dynamic deletedAt;
    final dynamic deletedBy;

    Jabatan({
        this.id,
        this.kode,
        this.jatahCutiTahunan,
        this.namaJabatan,
        this.keterangan,
        this.potonganTelat,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.isDelete,
        this.deletedAt,
        this.deletedBy,
    });

    factory Jabatan.fromJson(Map<String, dynamic> json) => Jabatan(
        id: json["id"],
        kode: json["kode"],
        jatahCutiTahunan: json["jatah_cuti_tahunan"],
        namaJabatan: json["nama_jabatan"],
        keterangan: json["keterangan"],
        potonganTelat: json["potongan_telat"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        isDelete: json["is_delete"],
        deletedAt: json["deleted_at"],
        deletedBy: json["deleted_by"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "jatah_cuti_tahunan": jatahCutiTahunan,
        "nama_jabatan": namaJabatan,
        "keterangan": keterangan,
        "potongan_telat": potonganTelat,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "is_delete": isDelete,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy,
    };
}

class Users {
    final int? id;
    final String? email;
    final int? status;
    final dynamic emailVerifiedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? idPegawai;
    final String? createdBy;
    final String? updatedBy;
    final bool? isDelete;
    final dynamic deletedAt;
    final dynamic deletedBy;

    Users({
        this.id,
        this.email,
        this.status,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.idPegawai,
        this.createdBy,
        this.updatedBy,
        this.isDelete,
        this.deletedAt,
        this.deletedBy,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        email: json["email"],
        status: json["status"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        idPegawai: json["id_pegawai"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        isDelete: json["is_delete"],
        deletedAt: json["deleted_at"],
        deletedBy: json["deleted_by"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "status": status,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id_pegawai": idPegawai,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "is_delete": isDelete,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy,
    };
}

class Jadwal {
    final int? id;
    final int? idPegawai;
    final int? idShift;
    final int? tahun;
    final String? bulan;
    final String? d08;
    final Shift? shift;

    Jadwal({
        this.id,
        this.idPegawai,
        this.idShift,
        this.tahun,
        this.bulan,
        this.d08,
        this.shift,
    });

    factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        id: json["id"],
        idPegawai: json["id_pegawai"],
        idShift: json["id_shift"],
        tahun: json["tahun"],
        bulan: json["bulan"],
        d08: json["D08"],
        shift: json["shift"] == null ? null : Shift.fromJson(json["shift"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_pegawai": idPegawai,
        "id_shift": idShift,
        "tahun": tahun,
        "bulan": bulan,
        "D08": d08,
        "shift": shift?.toJson(),
    };
}

class Shift {
    final int? id;
    final String? namaShift;
    final String? jamMulai;
    final String? jamSelesai;

    Shift({
        this.id,
        this.namaShift,
        this.jamMulai,
        this.jamSelesai,
    });

    factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["id"],
        namaShift: json["nama_shift"] ?? "",
        jamMulai: json["masuk"] ?? "",
        jamSelesai: json["pulang"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_shift": namaShift,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
    };
}
