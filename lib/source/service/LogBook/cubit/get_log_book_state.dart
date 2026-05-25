part of 'get_log_book_cubit.dart';

@immutable
sealed class GetLogBookState {}

final class GetLogBookInitial extends GetLogBookState {}

final class GetLogBookLoading extends GetLogBookState {}

final class GetLogBookFailed extends GetLogBookState {
  final int? statusCode;
  final dynamic json;

  GetLogBookFailed({required this.statusCode, required this.json});
}

final class GetLogBookLoaded extends GetLogBookState {
  final int? statusCode, idPegawai;
  final ModelLogBook? model;

  GetLogBookLoaded({required this.statusCode, required this.idPegawai, required this.model});
}
