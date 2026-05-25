part of 'get_absensi_cubit.dart';

@immutable
sealed class GetAbsensiState {}

final class GetAbsensiInitial extends GetAbsensiState {}

final class GetAbsensiLoading extends GetAbsensiState {}

final class GetAbsensiFailed extends GetAbsensiState {
  final int? statusCode;
  final dynamic json;

  GetAbsensiFailed({required this.statusCode, required this.json});
}

final class GetAbsensiLoaded extends GetAbsensiState {
  final int? statusCode, idPegawai;

  final ModelDataAbsensi? model;

  GetAbsensiLoaded({required this.statusCode, required this.model, this.idPegawai});
}
