part of 'jenis_izin_cubit.dart';

@immutable
sealed class JenisIzinState {}

final class JenisIzinInitial extends JenisIzinState {}

final class JenisIzinLoading extends JenisIzinState {}

final class JenisIzinFailed extends JenisIzinState {
  final int? statusCode;
  final dynamic json;

  JenisIzinFailed({required this.statusCode, required this.json});
}

final class JenisIzinLoaded extends JenisIzinState {
  final int? statusCode;
  final ModelJenisizin? model;

  JenisIzinLoaded({required this.statusCode, required this.model});
}
