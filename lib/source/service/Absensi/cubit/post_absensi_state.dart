part of 'post_absensi_cubit.dart';

@immutable
sealed class PostAbsensiState {}

final class PostAbsensiInitial extends PostAbsensiState {}

final class PostAbsensiLoading extends PostAbsensiState {}
final class PostAbsensiFailed extends PostAbsensiState {
  final int? statusCode;
  final dynamic json;

  PostAbsensiFailed({required this.statusCode, required this.json});

}

final class PostAbsensiLoaded extends PostAbsensiState {
  final int? statusCode;
  final dynamic json;

  PostAbsensiLoaded({required this.statusCode, required this.json});
}
