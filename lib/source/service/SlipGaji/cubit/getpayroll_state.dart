part of 'getpayroll_cubit.dart';

@immutable
sealed class GetpayrollState {}

final class GetpayrollInitial extends GetpayrollState {}

final class GetpayrollLoading extends GetpayrollState {}

final class GetpayrollLoaded extends GetpayrollState {
  final int? statusCode;
  final ModelPayroll? model;

  GetpayrollLoaded({required this.statusCode, required this.model});
}

final class GetpayrollFailed extends GetpayrollState {
  final int? statusCode;
  final dynamic json;

  GetpayrollFailed({required this.statusCode, required this.json});
}
