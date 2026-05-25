import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sihr/source/env/env.dart';
import 'package:sihr/source/repository/RepositoryAbsensi.dart';
import 'package:sihr/source/repository/RepositoryApproval.dart';
import 'package:sihr/source/repository/RepositoryAuth.dart';
import 'package:sihr/source/repository/RepositoryLogBook.dart';
import 'package:sihr/source/repository/RepositoryPelatihan.dart';
import 'package:sihr/source/repository/RepositoryPengumuman.dart';
import 'package:sihr/source/repository/RepositoryShift.dart';
import 'package:sihr/source/repository/RepositorySlipGaji.dart';
import 'package:sihr/source/repository/repositoryCuti.dart';
import 'package:sihr/source/repository/repositoryIzin.dart';
import 'package:sihr/source/repository/repositoryLembur.dart';
import 'package:sihr/source/repository/repositoryPegawai.dart';
import 'package:sihr/source/router/router.dart';
import 'package:sihr/source/service/Absensi/cubit/get_absensi_cubit.dart';
import 'package:sihr/source/service/Absensi/cubit/get_sisa_absen_cubit.dart';
import 'package:sihr/source/service/Absensi/cubit/jenis_absen_cubit.dart';
import 'package:sihr/source/service/Absensi/cubit/post_absensi_cubit.dart';
import 'package:sihr/source/service/Approval/cubit/approval_cubit.dart';
import 'package:sihr/source/service/Auth/cubit/change_password_cubit.dart';
import 'package:sihr/source/service/Auth/cubit/auth_cubit.dart';
import 'package:sihr/source/service/CheckPermission/cubit/check_permission_cubit.dart';
import 'package:sihr/source/service/Cuti/cubit/create_cuti_cubit.dart';
import 'package:sihr/source/service/Cuti/cubit/get_cuti_cubit.dart';
import 'package:sihr/source/service/Cuti/cubit/jenis_cuti_cubit.dart';
import 'package:sihr/source/service/Izin/cubit/create_izin_cubit.dart';
import 'package:sihr/source/service/Izin/cubit/get_izin_cubit.dart';
import 'package:sihr/source/service/Izin/cubit/jenis_izin_cubit.dart';
import 'package:sihr/source/service/Lembur/cubit/create_lembur_cubit.dart';
import 'package:sihr/source/service/Lembur/cubit/get_lembur_cubit.dart';
import 'package:sihr/source/service/LogBook/cubit/create_log_book_cubit.dart';
import 'package:sihr/source/service/LogBook/cubit/create_log_book_perawat_cubit.dart';
import 'package:sihr/source/service/LogBook/cubit/get_log_book_cubit.dart';
import 'package:sihr/source/service/LogBook/cubit/get_log_book_perawat_cubit.dart';
import 'package:sihr/source/service/LogBook/cubit/master_log_book_cubit.dart';
import 'package:sihr/source/service/LogBook/cubit/update_log_book_cubit.dart';
import 'package:sihr/source/service/LogBook/cubit/update_log_book_perawat_cubit.dart';
import 'package:sihr/source/service/MarkerLocation/cubit/marker_location_cubit.dart';
import 'package:sihr/source/service/Pelatihan/cubit/absen_pelatihan_cubit.dart';
import 'package:sihr/source/service/Pelatihan/cubit/jenis_pelatihan_cubit.dart';
import 'package:sihr/source/service/Pelatihan/cubit/kategori_pelatihan_cubit.dart';
import 'package:sihr/source/service/Pelatihan/cubit/pelatihan_cubit.dart';
import 'package:sihr/source/service/Pengumuman/cubit/get_pengumuman_cubit.dart';
import 'package:sihr/source/service/Pengumuman/cubit/get_pengumuman_peserta_cubit.dart';
import 'package:sihr/source/service/Pengumuman/cubit/update_pengumuman_peserta_cubit.dart';
import 'package:sihr/source/service/Shift/cubit/get_shift_cubit.dart';
import 'package:sihr/source/service/SlipGaji/cubit/get_slip_gaji_cubit.dart';
import 'package:sihr/source/service/SlipGaji/cubit/getpayroll_cubit.dart';
import 'package:sihr/source/service/pegawai/cubit/get_pegawai_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(MyApp(router: RouterNavigation()));
}

class MyApp extends StatelessWidget {
  RouterNavigation? router;
  MyApp({super.key, this.router});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuhtRepository()),
        RepositoryProvider(create: (context) => PegawaiRepository()),
        RepositoryProvider(create: (context) => AbsensiRepository()),
        RepositoryProvider(create: (context) => ShiftRepository()),
        RepositoryProvider(create: (context) => CutiRepository()),
        RepositoryProvider(create: (context) => LemburRepository()),
        RepositoryProvider(create: (context) => IzinRepository()),
        RepositoryProvider(create: (context) => Repositorypengumuman()),
        RepositoryProvider(create: (context) => PelatihanRepository()),
        RepositoryProvider(create: (context) => RepositoryLogBook()),
        RepositoryProvider(create: (context) => RepositorySlipGaji()),
        RepositoryProvider(create: (context) => RepostoryApproval()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit(repository: AuhtRepository())),
          BlocProvider(create: (context) => ChangePasswordCubit(repository: AuhtRepository())),
          BlocProvider(create: (context) => MarkerLocationCubit()),
          BlocProvider(create: (context) => CheckPermissionCubit()),
          // PEGAWAI
          BlocProvider(create: (context) => GetPegawaiCubit(repository: PegawaiRepository())),
          // ABSENSI
          BlocProvider(create: (context) => PostAbsensiCubit(repository: AbsensiRepository())),
          BlocProvider(create: (context) => GetAbsensiCubit(repository: AbsensiRepository())),
          BlocProvider(create: (context) => GetSisaAbsenCubit(repository: AbsensiRepository())),
          BlocProvider(create: (context) => JenisAbsenCubit(repository: AbsensiRepository())),
          //  SHIFT
          BlocProvider(create: (context) => GetShiftCubit(repository: ShiftRepository())),
          // CUTI
          BlocProvider(create: (context) => JenisCutiCubit(repository: CutiRepository())),
          BlocProvider(create: (context) => CreateCutiCubit(repository: CutiRepository())),
          BlocProvider(create: (context) => GetCutiCubit(repository: CutiRepository())),
          // LEMBUR
          BlocProvider(create: (context) => CreateLemburCubit(repository: LemburRepository())),
          BlocProvider(create: (context) => GetLemburCubit(repository: LemburRepository())),
          // IZIN
          BlocProvider(create: (context) => JenisIzinCubit(repository: IzinRepository())),
          BlocProvider(create: (context) => CreateIzinCubit(repository: IzinRepository())),
          BlocProvider(create: (context) => GetIzinCubit(repository: IzinRepository())),
          // pengumuman
          BlocProvider(create: (context) => GetPengumumanCubit(repository: Repositorypengumuman())),
          BlocProvider(create: (context) => GetPengumumanPesertaCubit(repository: Repositorypengumuman())),
          BlocProvider(create: (context) => UpdatePengumumanPesertaCubit(repository: Repositorypengumuman())),
          // pelatihan
          BlocProvider(create: (context) => JenisPelatihanCubit(repository: PelatihanRepository())),
          BlocProvider(create: (context) => PelatihanCubit(repository: PelatihanRepository())),
          BlocProvider(create: (context) => KategoriPelatihanCubit(repository: PelatihanRepository())),
          BlocProvider(create: (context) => AbsenPelatihanCubit(repository: PelatihanRepository())),
          // LOG BOOK
          BlocProvider(create: (context) => GetLogBookCubit(repository: RepositoryLogBook())),
          BlocProvider(create: (context) => CreateLogBookCubit(repository: RepositoryLogBook())),
          BlocProvider(create: (context) => UpdateLogBookCubit(repository: RepositoryLogBook())),
          BlocProvider(create: (context) => MasterLogBookCubit(repository: RepositoryLogBook())),
          BlocProvider(create: (context) => CreateLogBookPerawatCubit(repository: RepositoryLogBook())),
          BlocProvider(create: (context) => GetLogBookPerawatCubit(repository: RepositoryLogBook())),
          BlocProvider(create: (context) => UpdateLogBookPerawatCubit(repository: RepositoryLogBook())),
          // SLIP GAJI
          BlocProvider(create: (context) => GetSlipGajiCubit(repository: RepositorySlipGaji())),
          BlocProvider(create: (context) => GetpayrollCubit(repository: RepositorySlipGaji())),
          //approval
          BlocProvider(create: (context) => ApprovalCubit(repository: RepostoryApproval())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: hijau,
            primaryColorLight: hijauLight,
            primaryColorDark: hijauDark,
            scaffoldBackgroundColor: whiteCustom,
            secondaryHeaderColor: whiteCustom,
            colorScheme: ColorScheme.fromSeed(
              seedColor: whiteCustom,
              brightness: Brightness.light, // or Brightness.dark
              // primary: whiteCustom, // Main color of the app
              onPrimary: Colors.white, // Text color on top of the primary color
              // secondary: whiteCustom, // Used for accents, buttons, etc.
              onSecondary: Colors.black, // Text color on top of the secondary color
              surface: Colors.white, // Background of cards, dialogs, etc.
              onSurface: Colors.black, // Text color on top of surfaces
              error: Colors.red, // Color for errors
              onError: Colors.red, // Text color on top of the error color
            ),
            appBarTheme: const AppBarTheme(color: whiteCustom),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: hijauLight),
            inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: hijau, // Warna border aktif global
                    width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, // Warna border saat tidak aktif secara global
                    width: 1.0),
              ),
            ),
            textSelectionTheme: const TextSelectionThemeData(cursorColor: hijau),
          ),
          builder: EasyLoading.init(),
          onGenerateRoute: router!.generateRoute,
        ),
      ),
    );
  }
}
