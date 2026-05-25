part of 'update_pengumuman_peserta_cubit.dart';

@immutable
sealed class UpdatePengumumanPesertaState {}

final class UpdatePengumumanPesertaInitial extends UpdatePengumumanPesertaState {}

final class UpdatePengumumanPesertaLoading extends UpdatePengumumanPesertaState {}

final class UpdatePengumumanPesertaFailed extends UpdatePengumumanPesertaState {
  final int? statusCode;
  final dynamic json;

  UpdatePengumumanPesertaFailed({required this.statusCode, required this.json});
}

final class UpdatePengumumanPesertaLoaded extends UpdatePengumumanPesertaState {
  final int? statusCode;
  final dynamic json;

  UpdatePengumumanPesertaLoaded({required this.statusCode, required this.json});
}
