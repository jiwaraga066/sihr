part of 'update_log_book_cubit.dart';

@immutable
sealed class UpdateLogBookState {}

final class UpdateLogBookInitial extends UpdateLogBookState {}

final class UpdateLogBookLoading extends UpdateLogBookState {}

final class UpdateLogBookFailed extends UpdateLogBookState {
  final int? statusCode;
  final dynamic json;

  UpdateLogBookFailed({required this.statusCode, required this.json});
}

final class UpdateLogBookLoaded extends UpdateLogBookState {
  final int? statusCode;
  final dynamic json;

  UpdateLogBookLoaded({required this.statusCode, required this.json});
}
