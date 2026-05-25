import 'package:flutter/material.dart';
import 'package:sihr/source/router/string.dart';

import '../pages/index.dart';

class RouterNavigation {
  SlideTransition bottomToTop(context, animation, secondaryAnimation, child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween), child: child);
  }

  SlideTransition topToBottom(context, animation, secondaryAnimation, child) {
    const begin = Offset(0.0, -1.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween), child: child);
  }

  SlideTransition rightToLeft(context, animation, secondaryAnimation, child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  SlideTransition leftToRight(context, animation, secondaryAnimation, child) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const SplashScreen(),
          transitionsBuilder: bottomToTop,
        );
      case loginScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
          transitionsBuilder: bottomToTop,
        );
      case changePasswordScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const ChangePasswordScreen(), transitionsBuilder: bottomToTop, settings: settings);
      case dashboardScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const DashboardScreen(),
          transitionsBuilder: topToBottom,
        );
      case cvScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const CVScreen(),
          transitionsBuilder: topToBottom,
        );
      case profileScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const ProfileScreen(),
          transitionsBuilder: topToBottom,
        );
      case absensiScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const AbsensiScreen(),
          transitionsBuilder: rightToLeft,
        );
      case dataAbsensiScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const DataAbsensiScreen(),
          transitionsBuilder: rightToLeft,
        );
      // lembur
      case lemburScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LemburScreen(),
          transitionsBuilder: rightToLeft,
        );
      case createLemburScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const CreateLemburScreen(),
          transitionsBuilder: rightToLeft,
        );
      // cuti
      case cutiScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const CutiScreen(),
          transitionsBuilder: rightToLeft,
        );
      case createCutiScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const CreateCutiScreen(),
          transitionsBuilder: rightToLeft,
        );
      // izin
      case izinScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const IzinScreen(),
          transitionsBuilder: rightToLeft,
        );
      case createIzinScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const CreateIzinScreen(),
          transitionsBuilder: rightToLeft,
        );
      // news
      case newsScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const NewsScreen(),
          transitionsBuilder: rightToLeft,
        );
      case newsCheckinScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const CheckInNewsScreen(),
          transitionsBuilder: rightToLeft,
        );
      // pelatihan
      case pelatihanScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const PelatihanScreen(),
          transitionsBuilder: rightToLeft,
        );
      case addPartisipasiScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const AddPartisipasiPelatihanScreen(),
          transitionsBuilder: rightToLeft,
        );
      case addResumePelatihanScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const AddResumePelatihanScreen(),
          transitionsBuilder: rightToLeft,
        );
      // Log Book
      case logbookScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LogBookScreen(),
          transitionsBuilder: rightToLeft,
        );
      case createlogbookScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const CreateLogBookScreen(),
          transitionsBuilder: rightToLeft,
        );
      case updatelogbookScreen:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => const UpdateLogBookScreen(),
          transitionsBuilder: rightToLeft,
        );
      case logbookPerawatScreen:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => const LogBookPerawatScreen(),
          transitionsBuilder: rightToLeft,
        );
      case createlogbookPerawatScreen:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => const CreateLogBookPerawatScreen(),
          transitionsBuilder: rightToLeft,
        );
      case updatelogbookPerawatScreen:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => const UpdateLogBookPerawatScreen(),
          transitionsBuilder: rightToLeft,
        );
      //  slipgaji
      case slipgajiScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const SlipGajiScreen(),
          transitionsBuilder: rightToLeft,
        );
      case detailSlipgajiScreen:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => const DetailSlipGajiScreen(),
          transitionsBuilder: rightToLeft,
        );
      // approval
      case approvalScreen:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => const ApprovalScreen(),
          transitionsBuilder: rightToLeft,
        );
      case approvalDetailScreen:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => const ApprovalDetailScreen(),
          transitionsBuilder: topToBottom,
        );

      default:
        return null;
    }
  }
}
