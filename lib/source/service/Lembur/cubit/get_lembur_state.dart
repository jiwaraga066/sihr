part of 'get_lembur_cubit.dart';

@immutable
sealed class GetLemburState {}

final class GetLemburInitial extends GetLemburState {}

final class GetLemburLoading extends GetLemburState {}

final class GetLemburFailed extends GetLemburState {
  final int? statusCode;
  final dynamic json;

  GetLemburFailed({required this.statusCode, required this.json});
}

final class GetLemburLoaded extends GetLemburState {
  final int? statusCode, idPegawai;
  final ModelLembur? model;

  GetLemburLoaded({required this.statusCode, required this.model, this.idPegawai});
}
