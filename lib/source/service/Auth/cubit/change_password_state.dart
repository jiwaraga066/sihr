part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordFailed extends ChangePasswordState {
  final int? statusCode;
  final dynamic json;

  ChangePasswordFailed({required this.statusCode, required this.json});
}

final class ChangePasswordLoaded extends ChangePasswordState {
  final int? statusCode;
  final dynamic json;

  ChangePasswordLoaded({required this.statusCode, required this.json});
}
