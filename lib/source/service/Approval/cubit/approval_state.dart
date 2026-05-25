part of 'approval_cubit.dart';

@immutable
sealed class ApprovalState {}

final class ApprovalInitial extends ApprovalState {}

final class ApprovalLoading extends ApprovalState {}

final class ApprovalFailed extends ApprovalState {
  final int? statusCode;
  final dynamic json;

  ApprovalFailed({required this.statusCode, required this.json});
}

final class ApprovalLoaded extends ApprovalState {
  final int? statusCode;
  final dynamic json;

  ApprovalLoaded({required this.statusCode, required this.json});
}
