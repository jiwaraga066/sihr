part of 'get_pengumuman_cubit.dart';

@immutable
sealed class GetPengumumanState {}

final class GetPengumumanInitial extends GetPengumumanState {}

final class GetPengumumanLoading extends GetPengumumanState {}

final class GetPengumumanFailed extends GetPengumumanState {
  final int? statusCode;
  final dynamic json;

  GetPengumumanFailed({required this.statusCode, required this.json});
}

final class GetPengumumanLoaded extends GetPengumumanState {
  final int? statusCode;
  final ModelPengumuman? model;

  GetPengumumanLoaded({required this.statusCode, required this.model});
}
