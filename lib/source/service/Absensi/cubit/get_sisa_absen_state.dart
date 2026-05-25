part of 'get_sisa_absen_cubit.dart';

@immutable
sealed class GetSisaAbsenState {}

final class GetSisaAbsenInitial extends GetSisaAbsenState {}

final class GetSisaAbsenLoading extends GetSisaAbsenState {}

final class GetSisaAbsenFailed extends GetSisaAbsenState {
  final int? statusCode;
  final dynamic json;

  GetSisaAbsenFailed({required this.statusCode, required this.json});
}

final class GetSisaAbsenLoaded extends GetSisaAbsenState {
  final int? statusCode;
  final ModelSisaAbsen? model;

  GetSisaAbsenLoaded({required this.statusCode, required this.model});
}
