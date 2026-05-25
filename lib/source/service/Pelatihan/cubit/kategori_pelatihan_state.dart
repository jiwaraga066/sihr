part of 'kategori_pelatihan_cubit.dart';

@immutable
sealed class KategoriPelatihanState {}

final class KategoriPelatihanInitial extends KategoriPelatihanState {}

final class KategoriPelatihanLoading extends KategoriPelatihanState {}

final class KategoriPelatihanFailed extends KategoriPelatihanState {
  final int? statusCode;
  final dynamic json;

  KategoriPelatihanFailed({required this.statusCode, required this.json});
}

final class KategoriPelatihanLoaded extends KategoriPelatihanState {
  final int? statusCode;
  final ModelKategoriPelatihan? model;

  KategoriPelatihanLoaded({required this.statusCode, required this.model});
}
