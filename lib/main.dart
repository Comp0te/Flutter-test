import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';
import 'src/blocs/blocs.dart';
import 'src/data_providers/data_providers.dart';
import 'src/databases/databases.dart';
import 'src/helpers/helpers.dart';
import 'src/repositories/repositories.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final dio = DioInstance().dio;
  final _secureStorageRepository = SecureStorageRepository(
    storage: SecureStorageProvider(secureStorage: const FlutterSecureStorage()),
  );
  final _authRepository = AuthRepository(
    authApiProvider: AuthApiProvider(
      dio: dio,
      googleSignIn: GoogleSignIn(),
      facebookLogin: FacebookLogin(),
    ),
  );
  final _postersRepository = PostersRepository(
    postersApiProvider: PostersApiProvider(dio: dio),
  );
  final _dbRepository = DBRepository(
    dbProvider: DBProvider(db: SQFLite().db),
  );
  final _imageStoreRepository = ImageStoreRepository(
    imageStoreProvider: ImageStoreProvider(),
  );
  final _cameraRepository = CameraRepository(
    cameraProvider: CameraProvider(),
  );
  final _firebaseMessagingRepository = FirebaseMessagingRepository(
    firebaseMessagingProvider: FirebaseMessagingProvider(
      firebaseMessaging: FirebaseMessaging(),
    ),
  );
  final _sharedPreferencesRepository = SharedPreferencesRepository(
    sharedPreferencesProvider: SharedPreferencesProvider(
      sharedPreferencesInstance: SharedPreferences.getInstance(),
    ),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          builder: (context) => AuthBloc(
            secureStorageRepository: _secureStorageRepository,
            authRepository: _authRepository,
          ),
        ),
        BlocProvider<AppStateBloc>(
          builder: (context) => AppStateBloc(
            dbRepository: _dbRepository,
            imageStoreRepository: _imageStoreRepository,
          ),
        ),
        BlocProvider<NavigationBloc>(
          builder: (context) => NavigationBloc(),
        ),
        BlocProvider<FirebaseMessagingBloc>(
          builder: (context) => FirebaseMessagingBloc(
            firebaseMessagingRepository: _firebaseMessagingRepository,
          ),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<SecureStorageRepository>(builder: (context) {
            return _secureStorageRepository;
          }),
          RepositoryProvider<AuthRepository>(builder: (context) {
            return _authRepository;
          }),
          RepositoryProvider<PostersRepository>(builder: (context) {
            return _postersRepository;
          }),
          RepositoryProvider<DBRepository>(builder: (context) {
            return _dbRepository;
          }),
          RepositoryProvider<ImageStoreRepository>(builder: (context) {
            return _imageStoreRepository;
          }),
          RepositoryProvider<CameraRepository>(builder: (context) {
            return _cameraRepository;
          }),
          RepositoryProvider<FirebaseMessagingRepository>(builder: (context) {
            return _firebaseMessagingRepository;
          }),
        ],
        child: App(),
      ),
    ),
  );
}
