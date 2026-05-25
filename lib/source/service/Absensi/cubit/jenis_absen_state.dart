part of 'jenis_absen_cubit.dart';

@immutable
sealed class JenisAbsenState {}

final class JenisAbsenInitial extends JenisAbsenState {}

final class JenisAbsenLoading extends JenisAbsenState {}

final class JenisAbsenFailed extends JenisAbsenState {
  final int? statusCode;
  final dynamic json;

  JenisAbsenFailed({required this.statusCode, required this.json});
}

final class JenisAbsenLoaded extends JenisAbsenState {
  final int? statusCode;
  final ModelJenisAbsen? model;

  JenisAbsenLoaded({required this.statusCode, required this.model});
}
