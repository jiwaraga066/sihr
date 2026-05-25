part of 'create_cuti_cubit.dart';

@immutable
sealed class CreateCutiState {}

final class CreateCutiInitial extends CreateCutiState {}

final class CreateCutiLoading extends CreateCutiState {}

final class CreateCutiFailed extends CreateCutiState {
  final int? statusCode;
  final dynamic json;

  CreateCutiFailed({required this.statusCode, required this.json});
}

final class CreateCutiLoaded extends CreateCutiState {
  final int? statusCode;
  final dynamic json;

  CreateCutiLoaded({required this.statusCode, required this.json});
}
