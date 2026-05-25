part of 'pelatihan_cubit.dart';

@immutable
sealed class PelatihanState {}

final class PelatihanInitial extends PelatihanState {}

final class PelatihanLoading extends PelatihanState {}

final class PelatihanFailed extends PelatihanState {
  final int? statusCode;
  final dynamic json;

  PelatihanFailed({required this.statusCode, required this.json});
}

final class PelatihanLoaded extends PelatihanState {
  final int? statusCode,idPegawai;
  final ModelPelatihan? modelPelatihan;

  PelatihanLoaded({required this.statusCode, required this.modelPelatihan, this.idPegawai});
}
