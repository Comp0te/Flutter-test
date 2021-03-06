import 'package:dio/dio.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/helpers/helpers.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
class AuthApiProvider {
  final Dio _dio;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;

  AuthApiProvider({
    @required Dio dio,
    @required GoogleSignIn googleSignIn,
    @required FacebookLogin facebookLogin,
  })  : assert(dio != null),
        assert(googleSignIn != null),
        assert(facebookLogin != null),
        _dio = dio,
        _googleSignIn = googleSignIn,
        _facebookLogin = facebookLogin;

  void addHeaders(Iterable<MapEntry<String, String>> headers) {
    _dio.options.headers.addEntries(headers);
  }

  void addTokenInterceptor(
    SecureStorageRepository secureStorageRepository,
    VoidCallback onLogout,
  ) {
    _dio.interceptors.add(DioInstance.getTokenInterceptor(
      dio: _dio,
      secureStorageRepository: secureStorageRepository,
      onLogout: onLogout,
    ));
  }

  Future<AuthResponse> login(LoginInput data) async {
    final response = await _dio.post<Map<String, dynamic>>(
      Url.login,
      data: data.toJson(),
    );

    return AuthResponse.fromJson(response.data);
  }

  Future<AccessToken> getGoogleAccessToken() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;

    return AccessToken(googleAuth.accessToken);
  }

  Future<AccessToken> getFacebookAccessToken() async {
    final result = await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        return AccessToken(result.accessToken.token);

      case FacebookLoginStatus.cancelledByUser:
        return null;

      case FacebookLoginStatus.error:
        throw result.errorMessage;
    }

    return null;
  }

  Future<AuthResponse> googleLogin() async {
    final googleAccessToken = await getGoogleAccessToken();

    final response = await _dio.post<Map<String, dynamic>>(
      Url.loginGoogle,
      data: googleAccessToken.toJson(),
    );

    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> facebookLogin() async {
    final facebookAccessToken = await getFacebookAccessToken();
    if (facebookAccessToken != null) {
      final response = await _dio.post<Map<String, dynamic>>(
        Url.loginFacebook,
        data: facebookAccessToken.toJson(),
      );

      return AuthResponse.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<AuthResponse> register(RegisterInput data) async {
    final response = await _dio.post<Map<String, dynamic>>(
      Url.register,
      data: data.toJson(),
    );

    return AuthResponse.fromJson(response.data);
  }

  Future<Token> verifyToken(Token data) async {
    final response = await _dio.post<Map<String, dynamic>>(
      Url.tokenVerify,
      data: data.toJson(),
    );

    return Token.fromJson(response.data);
  }

  Future<void> logout() async {
    await _dio.post<Map<String, dynamic>>(
      Url.logout,
    );
  }

  Future<void> googleLogout() async {
    final signedIn = await _googleSignIn.isSignedIn();

    if (signedIn) await _googleSignIn.disconnect();
  }

  Future<void> facebookLogout() async {
    final loggedIn = await _facebookLogin.isLoggedIn;

    if (loggedIn) await _facebookLogin.logOut();
  }
}
