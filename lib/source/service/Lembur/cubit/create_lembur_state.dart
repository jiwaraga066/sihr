part of 'create_lembur_cubit.dart';

@immutable
sealed class CreateLemburState {}

final class CreateLemburInitial extends CreateLemburState {}

final class CreateLemburLoading extends CreateLemburState {}

final class CreateLemburFailed extends CreateLemburState {
  final int? statusCode;
  final dynamic json;

  CreateLemburFailed({required this.statusCode, required this.json});
}

final class CreateLemburLoaded extends CreateLemburState {
  final int? statusCode;
  final dynamic json;

  CreateLemburLoaded({required this.statusCode, required this.json});
}
