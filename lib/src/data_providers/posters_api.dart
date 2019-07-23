import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import 'package:flutter_app/src/utils/constants.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
class PostersApiProvider {
  final Dio _dio;

  PostersApiProvider({@required Dio dio}) : _dio = dio;

  Future<PostersFetchResponse> fetchPosters(int page) async {
    Response response = page == null
        ? await _dio.get(
            Url.posters,
          )
        : await _dio.get(
            Url.posters,
            queryParameters: {
              'page': page,
            },
          );

    return PostersFetchResponse.fromJson(response.data);
  }
}
