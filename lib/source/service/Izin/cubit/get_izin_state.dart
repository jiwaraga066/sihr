part of 'get_izin_cubit.dart';

@immutable
sealed class GetIzinState {}

final class GetIzinInitial extends GetIzinState {}

final class GetIzinLoading extends GetIzinState {}

final class GetIzinFailed extends GetIzinState {
  final int? statusCode;
  final dynamic json;

  GetIzinFailed({required this.statusCode, required this.json});
}

final class GetIzinLoaded extends GetIzinState {
  final int? statusCode, idPegawai;
  final ModelIzin? model;

  GetIzinLoaded({required this.statusCode, required this.model, this.idPegawai});
}
