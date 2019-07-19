import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import 'package:flutter_app/src/utils/constants.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
class PostersApiProvider {
  final Dio _dio;

  PostersApiProvider({@required Dio dio}) : _dio = dio;

  Future<PostersFetchResponse> fetchPosters() async {
    Response response = await _dio.get(
      Url.posters,
    );

    return PostersFetchResponse.fromJson(response.data);
  }
}