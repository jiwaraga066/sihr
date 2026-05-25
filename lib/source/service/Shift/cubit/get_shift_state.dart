part of 'get_shift_cubit.dart';

@immutable
sealed class GetShiftState {}

final class GetShiftInitial extends GetShiftState {}
final class GetShiftLoading extends GetShiftState {}

final class GetShiftFailed extends GetShiftState {
  final int? statusCode;
  final String? messageError;

  GetShiftFailed({required this.statusCode, required this.messageError});
}

final class GetShiftLoaded extends GetShiftState {
  final int? statusCode;
  final ModelShift? model;

  GetShiftLoaded({required this.statusCode, required this.model});
}
