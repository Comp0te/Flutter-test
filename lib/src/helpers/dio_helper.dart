import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

Object _parseAndDecode(String response) {
  return jsonDecode(response);
}

Future<Object> parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class DioInstance {
  final Dio _dio;

  DioInstance() : _dio = Dio(options) {
    (_dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  }

  Dio get dio {
    if (kReleaseMode) {
      return _dio;
    }

//    configureProxy();

    return _dio;
  }

  static const authorizationKey = 'Authorization';
  static String getAuthorizationValue(String token) => 'JWT $token';
  static BaseOptions options = BaseOptions(
    baseUrl: Url.base,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.json,
  );

  static InterceptorsWrapper getTokenInterceptor({
    @required Dio dio,
    @required SecureStorageRepository secureStorageRepository,
    @required VoidCallback onLogout,
  }) {
    final _tokenDio = Dio(options);

    return InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        final token = await secureStorageRepository.getToken();

        if (token != null) {
          options.headers[authorizationKey] = getAuthorizationValue(token);
        } else {
          options.headers.removeWhere((key, _) => key == authorizationKey);
        }

        return options;
      },
      onError: (DioError error) async {
        final statusCode = error.response?.statusCode;

        // Assume 401 stands for token expired
        if (statusCode == 401 || statusCode == 400) {
          final token = await secureStorageRepository.getToken();
          final options = error.response.request;
          // If the token has been updated, repeat directly.

          if (token != options.headers[authorizationKey]) {
            options.headers[authorizationKey] = token;
            //repeat
            return dio.request(options.path, options: options);
          }

          // update token and repeat
          // Lock to block the incoming request until the token updated
          try {
            dio.lock();
            dio.interceptors.responseLock.lock();
            dio.interceptors.errorLock.lock();

            final refreshTokenResponse =
                await _tokenDio.post<Map<String, dynamic>>(
              Url.tokenRefresh,
              data: Token(token).toJson(),
            );

            final refreshedToken =
                Token.fromJson(refreshTokenResponse.data).token;

            options.headers[authorizationKey] =
                getAuthorizationValue(refreshedToken);

            await secureStorageRepository.saveToken(token);

            return dio.request(options.path, options: options);
          } on Exception catch (_) {
            onLogout();
          } finally {
            dio.unlock();
            dio.interceptors.responseLock.unlock();
            dio.interceptors.errorLock.unlock();
          }

          return error;
        }

        return error;
      },
    );
  }

  void configureProxy() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (url) {
        return 'PROXY $urlProxyMan';
      };

      client.badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) {
        return Platform.isAndroid;
      };
    };
  }
}
