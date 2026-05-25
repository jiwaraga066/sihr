part of 'create_log_book_perawat_cubit.dart';

@immutable
sealed class CreateLogBookPerawatState {}

final class CreateLogBookPerawatInitial extends CreateLogBookPerawatState {}

final class CreateLogBookPerawatLoading extends CreateLogBookPerawatState {}

final class CreateLogBookPerawatFailed extends CreateLogBookPerawatState {
  final int? statusCode;
  final dynamic json;

  CreateLogBookPerawatFailed({required this.statusCode, required this.json});
}

final class CreateLogBookPerawatLoaded extends CreateLogBookPerawatState {
  final int? statusCode;
  final dynamic json;

  CreateLogBookPerawatLoaded({required this.statusCode, required this.json});
}
