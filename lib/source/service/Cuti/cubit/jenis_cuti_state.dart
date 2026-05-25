part of 'jenis_cuti_cubit.dart';

@immutable
sealed class JenisCutiState {}

final class JenisCutiInitial extends JenisCutiState {}

final class JenisCutiLoading extends JenisCutiState {}

final class JenisCutiFailed extends JenisCutiState {
  final int? statusCode;
  final dynamic json;

  JenisCutiFailed({required this.statusCode, required this.json});
}
final class JenisCutiLoaded extends JenisCutiState {
  final int? statusCode;
  final ModelJenisCuti? model;

  JenisCutiLoaded({required this.statusCode, required this.model});

}
