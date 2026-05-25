part of 'get_pengumuman_peserta_cubit.dart';

@immutable
sealed class GetPengumumanPesertaState {}

final class GetPengumumanPesertaInitial extends GetPengumumanPesertaState {}

final class GetPengumumanPesertaLoading extends GetPengumumanPesertaState {}

final class GetPengumumanPesertaFailed extends GetPengumumanPesertaState {
  final int? statusCode;
  final dynamic json;

  GetPengumumanPesertaFailed({required this.statusCode, required this.json});
}

final class GetPengumumanPesertaLoaded extends GetPengumumanPesertaState {
  final int? statusCode;
  final ModelPengumumanPeserta? model;

  GetPengumumanPesertaLoaded({required this.statusCode, required this.model});
}
