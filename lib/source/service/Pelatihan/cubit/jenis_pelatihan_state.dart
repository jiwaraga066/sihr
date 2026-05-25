part of 'jenis_pelatihan_cubit.dart';

@immutable
sealed class JenisPelatihanState {}

final class JenisPelatihanInitial extends JenisPelatihanState {}

final class JenisPelatihanLoading extends JenisPelatihanState {}

final class JenisPelatihanFailed extends JenisPelatihanState {
  final int? statusCode;
  final dynamic json;

  JenisPelatihanFailed({required this.statusCode, required this.json});
}

final class JenisPelatihanLoaded extends JenisPelatihanState {
  final int? statusCode;
  final Modeljenispelatihan? modeljenispelatihan;

  JenisPelatihanLoaded({required this.statusCode, required this.modeljenispelatihan});
}
