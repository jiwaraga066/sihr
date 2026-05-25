// To parse this JSON data, do
//
//     final modelPayroll = modelPayrollFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelPayroll modelPayrollFromJson(String str) => ModelPayroll.fromJson(json.decode(str));

class ModelPayroll {
    final List<Payroll> payroll;
    final Pegawai pegawai;
    final List<Pendapatan> pendapatan;
    final List<Pendapatan> potongan;

    ModelPayroll({
        required this.payroll,
        required this.pegawai,
        required this.pendapatan,
        required this.potongan,
    });

    factory ModelPayroll.fromJson(Map<String, dynamic> json) => ModelPayroll(
        payroll: List<Payroll>.from(json["payroll"].map((x) => Payroll.fromJson(x))),
        pegawai: Pegawai.fromJson(json["pegawai"]),
        pendapatan: List<Pendapatan>.from(json["pendapatan"].map((x) => Pendapatan.fromJson(x))),
        potongan: List<Pendapatan>.from(json["potongan"].map((x) => Pendapatan.fromJson(x))),
    );

}

class Payroll {
    final int id;
    final int idPegawai;
    final String noreff;
    final String bulan;
    final int tahun;
    final int pendapatan;
    final int potongan;
    final String catatan;

    Payroll({
        required this.id,
        required this.idPegawai,
        required this.noreff,
        required this.bulan,
        required this.tahun,
        required this.pendapatan,
        required this.potongan,
        required this.catatan,
    });

    factory Payroll.fromJson(Map<String, dynamic> json) => Payroll(
        id: json["id"],
        idPegawai: json["id_pegawai"],
        noreff: json["noreff"],
        bulan: json["bulan"],
        tahun: json["tahun"],
        pendapatan: json["pendapatan"],
        potongan: json["potongan"],
        catatan: json["catatan"] ?? "",
    );

}

class Pegawai {
    final String nik;
    final String golongan;
    final String nama;
    final String masaJabatan;
    final String pendidikan;
    final String npwp;
    final String jabatan;
    final String periode;

    Pegawai({
        required this.nik,
        required this.golongan,
        required this.nama,
        required this.masaJabatan,
        required this.pendidikan,
        required this.npwp,
        required this.jabatan,
        required this.periode,
    });

    factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
        nik: json["nik"],
        golongan: json["golongan"],
        nama: json["nama"],
        masaJabatan: json["masa_jabatan"],
        pendidikan: json["pendidikan"],
        npwp: json["npwp"],
        jabatan: json["jabatan"],
        periode: json["periode"],
    );

 
}

class Pendapatan {
    final int id;
    final String noreff;
    final int idKomponenGaji;
    final int nilai;
    final KomponenGaji komponenGaji;

    Pendapatan({
        required this.id,
        required this.noreff,
        required this.idKomponenGaji,
        required this.nilai,
        required this.komponenGaji,
    });

    factory Pendapatan.fromJson(Map<String, dynamic> json) => Pendapatan(
        id: json["id"],
        noreff: json["noreff"],
        idKomponenGaji: json["id_komponen_gaji"],
        nilai: json["nilai"],
        komponenGaji: KomponenGaji.fromJson(json["komponen_gaji"]),
    );

}

class KomponenGaji {
    final int id;
    final String namaKomponen;
    final String faktor;
    final String tipe;
    final String keterangan;

    KomponenGaji({
        required this.id,
        required this.namaKomponen,
        required this.faktor,
        required this.tipe,
        required this.keterangan,
    });

    factory KomponenGaji.fromJson(Map<String, dynamic> json) => KomponenGaji(
        id: json["id"],
        namaKomponen: json["nama_komponen"],
        faktor: json["faktor"],
        tipe: json["tipe"] ?? "",
        keterangan: json["keterangan"] ?? "",
    );

}
