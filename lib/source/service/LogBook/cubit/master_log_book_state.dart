part of 'master_log_book_cubit.dart';

@immutable
sealed class MasterLogBookState {}

final class MasterLogBookInitial extends MasterLogBookState {}

final class MasterLogBookLoading extends MasterLogBookState {}

final class MasterLogBookFailed extends MasterLogBookState {
  final int? statusCode;
  final dynamic json;

  MasterLogBookFailed({required this.statusCode, required this.json});
}

final class MasterLogBookLoaded extends MasterLogBookState {
  final int? statusCode;
  final ModelMasterLogBook? model;

  MasterLogBookLoaded({required this.statusCode, required this.model});
}
