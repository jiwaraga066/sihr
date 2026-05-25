part of 'get_log_book_perawat_cubit.dart';

@immutable
sealed class GetLogBookPerawatState {}

final class GetLogBookPerawatInitial extends GetLogBookPerawatState {}

final class GetLogBookPerawatLoading extends GetLogBookPerawatState {}

final class GetLogBookPerawatFailed extends GetLogBookPerawatState {
  final int? statusCode;
  final dynamic json;

  GetLogBookPerawatFailed({required this.statusCode, required this.json});
}

final class GetLogBookPerawatLoaded extends GetLogBookPerawatState {
  final int? statusCode;
  final ModelLogBookPerawat? model;

  GetLogBookPerawatLoaded({required this.statusCode, required this.model});
}
