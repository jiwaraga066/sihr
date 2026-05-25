part of 'create_log_book_cubit.dart';

@immutable
sealed class CreateLogBookState {}

final class CreateLogBookInitial extends CreateLogBookState {}

final class CreateLogBookLoading extends CreateLogBookState {}

final class CreateLogBookFailed extends CreateLogBookState {
  final int? statusCode;
  final dynamic json;

  CreateLogBookFailed({required this.statusCode, required this.json});
}

final class CreateLogBookLoaded extends CreateLogBookState {
  final int? statusCode;
  final dynamic json;

  CreateLogBookLoaded({required this.statusCode, required this.json});
}
