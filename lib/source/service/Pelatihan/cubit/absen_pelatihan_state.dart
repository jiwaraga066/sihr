part of 'absen_pelatihan_cubit.dart';

@immutable
sealed class AbsenPelatihanState {}

final class AbsenPelatihanInitial extends AbsenPelatihanState {}

final class AbsenPelatihanLoading extends AbsenPelatihanState {}

final class AbsenPelatihanFailed extends AbsenPelatihanState {
  final int? statusCode;
  final dynamic json;

  AbsenPelatihanFailed({required this.statusCode, required this.json});
}

final class AbsenPelatihanLoaded extends AbsenPelatihanState {
  final int? statusCode;
  final dynamic json;

  AbsenPelatihanLoaded({required this.statusCode, required this.json});
}
