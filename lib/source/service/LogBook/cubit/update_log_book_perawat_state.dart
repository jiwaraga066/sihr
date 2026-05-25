part of 'update_log_book_perawat_cubit.dart';

@immutable
sealed class UpdateLogBookPerawatState {}

final class UpdateLogBookPerawatInitial extends UpdateLogBookPerawatState {}

final class UpdateLogBookPerawatLoading extends UpdateLogBookPerawatState {}

final class UpdateLogBookPerawatFailed extends UpdateLogBookPerawatState {
  final int? statusCode;
  final dynamic json;

  UpdateLogBookPerawatFailed({required this.statusCode, required this.json});
}

final class UpdateLogBookPerawatLoaded extends UpdateLogBookPerawatState {
  final int? statusCode;
  final dynamic json;

  UpdateLogBookPerawatLoaded({required this.statusCode, required this.json});
}
