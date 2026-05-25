import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "Content-Type";
const String ACCEPT = "Accept";
const String AUTHORIZATION = "authorization";

const url = "https://api.hris.rsuumc.com";
const url2 = "https://api-v3.hris.rsuumc.com";
// const url2 = "https://api-v2.rsuumc.com";
var tanggal = DateFormat('yyyy-MM-dd').format(DateTime.now());
PermissionStatus? storagePermission;
PermissionStatus? locationPermission;
PermissionStatus? cameraPermission;

double latitudePlace = -6.803123267471703;
double longitudePlace = 108.61565805428894;

int selectedIndex = 0;

const hijau = Color(0XFF00712D);
const hijauDark = Color(0XFF1A5319);
const hijauLight = Color(0XFF508D4E);
const hijauLight2 = Color(0XFF80AF81);
const hijauDark2 = Color(0XFF00712D);
const hijauTeal1 = Color(0XFF41B3A2);
const whiteCustom = Color.fromRGBO(245, 245, 245, 1);
const whiteCustom2 = Color.fromARGB(255, 255, 255, 255);
const merah = Color(0XFFA91D3A);
const biru = Color(0XFF125B9A);
const amber = Color(0XFFFAB12F);

// data edit log book
var tanggalLogbook, namalog, keteranganlog, idlogbook;
var tanggalLogbookPerawat, jumlahLogBookPerawat, idLogbookPerawat, mlogbook, valuejenislogbook, valueketerangan, valuestatus;

// send param slip gaji
var id_slip_gaji;

// pelatihan
var id_pelatihan;
var id_partisipasi;

//detail approval
var idApproval, namaApproval, tanggalApproval, keteranganApproval, menuApproval;

// news
var idNews, statusAbsenNews;

// resumevalue
var valueResume;