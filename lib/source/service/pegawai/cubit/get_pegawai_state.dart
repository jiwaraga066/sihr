part of 'get_pegawai_cubit.dart';

@immutable
sealed class GetPegawaiState {}

final class GetPegawaiInitial extends GetPegawaiState {}

final class GetPegawaiLoading extends GetPegawaiState {}

final class GetPegawaiFailed extends GetPegawaiState {
  final int? statusCode;
  final String? messageError;

  GetPegawaiFailed({required this.statusCode, required this.messageError});
}

final class GetPegawaiLoaded extends GetPegawaiState {
  final int? statusCode;
  final ModelPegawai? model;

  GetPegawaiLoaded({required this.statusCode, required this.model});
}
