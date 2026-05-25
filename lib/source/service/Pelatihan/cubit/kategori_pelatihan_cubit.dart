import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sihr/source/model/ModelPelatihan/modelKategoriPelatihan.dart';
import 'package:sihr/source/repository/RepositoryPelatihan.dart';

part 'kategori_pelatihan_state.dart';

class KategoriPelatihanCubit extends Cubit<KategoriPelatihanState> {
  final PelatihanRepository? repository;
  KategoriPelatihanCubit({this.repository}) : super(KategoriPelatihanInitial());

  void getkategoriPelatihan(context) async {
    emit(KategoriPelatihanLoading());
    repository!.kategoriPelatihan(context).then((value) {
      var json = value.data;
      var statusCode = value.statusCode;
      print("GET KATEGORI: $json");
      if (statusCode == 200 || statusCode == 201) {
        emit(KategoriPelatihanLoaded(statusCode: statusCode, model: modelKategoriPelatihanFromJson(jsonEncode(json))));
      } else {
        emit(KategoriPelatihanFailed(statusCode: statusCode, json: json));
      }
    });
  }
}
