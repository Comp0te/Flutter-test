import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import 'package:flutter_app/src/utils/constants.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
class PostersApiProvider {
  final Dio _dio;

  PostersApiProvider({@required Dio dio}) : _dio = dio;

  Future<PostersFetchResponse> fetchPosters(int page) async {
    final response = page == null
        ? await _dio.get<Map<String, dynamic>>(
            Url.posters,
          )
        : await _dio.get<Map<String, dynamic>>(
            Url.posters,
            queryParameters: <String, dynamic>{
              'page': page,
            },
          );

    return PostersFetchResponse.fromJson(response.data);
  }
}
