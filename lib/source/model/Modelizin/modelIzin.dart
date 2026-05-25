// To parse this JSON data, do
//
//     final modelIzin = modelIzinFromJson(jsonString);

import 'dart:convert';

ModelIzin modelIzinFromJson(String str) => ModelIzin.fromJson(json.decode(str));

String modelIzinToJson(ModelIzin data) => json.encode(data.toJson());

class ModelIzin {
    final String? message;
    final int? count;
    final List<Datum>? data;

    ModelIzin({
        this.message,
        this.count,
        this.data,
    });

    factory ModelIzin.fromJson(Map<String, dynamic> json) => ModelIzin(
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
    final int? idJenisIzin;
    final DateTime? tanggal;
    final String? alasan;
    final int? status;
    final String? keterangan;
    final String? feedback;
    final int? userAcc;
    final DateTime? tglAcc;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic createdBy;
    final dynamic updatedBy;
    final int? isDelete;
    final dynamic deletedAt;
    final dynamic deletedBy;
    final Jenisizin? jenisizin;
    final Pegawai? pegawai;

    Datum({
        this.id,
        this.idPegawai,
        this.idJenisIzin,
        this.tanggal,
        this.alasan,
        this.status,
        this.keterangan,
        this.feedback,
        this.userAcc,
        this.tglAcc,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.isDelete,
        this.deletedAt,
        this.deletedBy,
        this.jenisizin,
        this.pegawai,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idPegawai: json["id_pegawai"] ?? 0,
        idJenisIzin: json["id_jenis_izin"] ?? 0,
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        alasan: json["alasan"] ?? "",
        status: json["status"] ?? 0,
        keterangan: json["keterangan"] ?? "",
        feedback: json["feedback"] ?? "",
        userAcc: json["user_acc"] ?? 0,
        tglAcc: json["tgl_acc"] == null ? null : DateTime.parse(json["tgl_acc"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        isDelete: json["is_delete"],
        deletedAt: json["deleted_at"],
        deletedBy: json["deleted_by"],
        jenisizin: json["jenisizin"] == null ? null : Jenisizin.fromJson(json["jenisizin"]),
        pegawai: json["pegawai"] == null ? null : Pegawai.fromJson(json["pegawai"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_pegawai": idPegawai,
        "id_jenis_izin": idJenisIzin,
        "tanggal": "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "alasan": alasan,
        "status": status,
        "keterangan": keterangan,
        "feedback": feedback,
        "user_acc": userAcc,
        "tgl_acc": tglAcc?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "is_delete": isDelete,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy,
        "jenisizin": jenisizin?.toJson(),
        "pegawai": pegawai?.toJson(),
    };
}

class Jenisizin {
    final int? id;
    final String? namaIzin;
    final String? keterangan;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? createdBy;
    final String? updatedBy;
    final int? isDelete;
    final dynamic deletedAt;
    final String? deletedBy;
    final String? namaDivisi;
    final String? kode;
    final String? namaJabatan;
    final int? potonganTelat;

    Jenisizin({
        this.id,
        this.namaIzin,
        this.keterangan,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.isDelete,
        this.deletedAt,
        this.deletedBy,
        this.namaDivisi,
        this.kode,
        this.namaJabatan,
        this.potonganTelat,
    });

    factory Jenisizin.fromJson(Map<String, dynamic> json) => Jenisizin(
        id: json["id"],
        namaIzin: json["nama_izin"],
        keterangan: json["keterangan"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        isDelete: json["is_delete"],
        deletedAt: json["deleted_at"],
        deletedBy: json["deleted_by"],
        namaDivisi: json["nama_divisi"],
        kode: json["kode"],
        namaJabatan: json["nama_jabatan"],
        potonganTelat: json["potongan_telat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_izin": namaIzin,
        "keterangan": keterangan,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "is_delete": isDelete,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy,
        "nama_divisi": namaDivisi,
        "kode": kode,
        "nama_jabatan": namaJabatan,
        "potongan_telat": potonganTelat,
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
    final dynamic idGolongan;
    final int? idJabatan;
    final int? idDivisi;
    final int? idDepartement;
    final int? idUnit;
    final int? idBank;
    final String? noRek;
    final String? foto;
    final String? hp;
    final dynamic pendidikan;
    final dynamic prodi;
    final String? npwp;
    final String? statusMenikah;
    final int? statusKeluarga;
    final dynamic tglResign;
    final dynamic ketResign;
    final int? statusResign;
    final String? nomr;
    final int? idKepalaBagian;
    final dynamic createdAt;
    final DateTime? updatedAt;
    final int? idUsers;
    final dynamic jatahCuti;
    final dynamic createdBy;
    final String? updatedBy;
    final int? isDelete;
    final dynamic deletedAt;
    final dynamic deletedBy;
    final Jenisizin? jabatan;
    final Jenisizin? divisi;

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
        this.createdAt,
        this.updatedAt,
        this.idUsers,
        this.jatahCuti,
        this.createdBy,
        this.updatedBy,
        this.isDelete,
        this.deletedAt,
        this.deletedBy,
        this.jabatan,
        this.divisi,
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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        idUsers: json["id_users"],
        jatahCuti: json["jatah_cuti"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        isDelete: json["is_delete"],
        deletedAt: json["deleted_at"],
        deletedBy: json["deleted_by"],
        jabatan: json["jabatan"] == null ? null : Jenisizin.fromJson(json["jabatan"]),
        divisi: json["divisi"] == null ? null : Jenisizin.fromJson(json["divisi"]),
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
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
        "id_users": idUsers,
        "jatah_cuti": jatahCuti,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "is_delete": isDelete,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy,
        "jabatan": jabatan?.toJson(),
        "divisi": divisi?.toJson(),
    };
}
