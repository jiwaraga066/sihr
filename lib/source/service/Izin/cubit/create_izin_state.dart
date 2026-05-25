part of 'create_izin_cubit.dart';

@immutable
sealed class CreateIzinState {}

final class CreateIzinInitial extends CreateIzinState {}

final class CreateIzinLoading extends CreateIzinState {}

final class CreateIzinFailed extends CreateIzinState {
  final int? statusCode;
  final dynamic json;

  CreateIzinFailed({required this.statusCode, required this.json});
}

final class CreateIzinLoaded extends CreateIzinState {
  final int? statusCode;
  final dynamic json;

  CreateIzinLoaded({required this.statusCode, required this.json});
}
