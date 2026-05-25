part of 'get_cuti_cubit.dart';

@immutable
sealed class GetCutiState {}

final class GetCutiInitial extends GetCutiState {}

final class GetCutiLoading extends GetCutiState {}

final class GetCutiFailed extends GetCutiState {
  final int? statusCode;
  final dynamic json;

  GetCutiFailed({required this.statusCode, required this.json});
}

final class GetCutiLoaded extends GetCutiState {
  final int? statusCode, idPegawai;
  final ModelCuti? model;

  GetCutiLoaded({required this.statusCode, required this.model, this.idPegawai});
}
