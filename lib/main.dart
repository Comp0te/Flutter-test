import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'src/app.dart';
import 'package:flutter_app/src/utils/helpers/dio_helper.dart';
import 'src/repositories/repositories.dart';
import 'src/data_providers/data_providers.dart';
import 'src/blocs/blocs.dart';
import 'src/database/database.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final Dio dio = DioInstance().dio;
  final SecureStorageRepository _secureStorageRepository =
      SecureStorageRepository(
    storage: SecureStorageProvider(secureStorage: FlutterSecureStorage()),
  );
  final AuthRepository _authRepository = AuthRepository(
    authApiProvider: AuthApiProvider(dio: dio),
  );
  final PostersRepository _postersRepository = PostersRepository(
    postersApiProvider: PostersApiProvider(dio: dio),
  );
  final DBRepository _dbRepository = DBRepository(
    dbProvider: DBProvider(db: DBHelper().db),
  );
  final ImageStoreRepository _imageStoreRepository = ImageStoreRepository(
    imageStoreProvider: ImageStoreProvider(),
  );
  CameraRepository _cameraRepository = CameraRepository(
    cameraProvider: CameraProvider(),
  );
  FirebaseMessagingRepository _firebaseMessaging = FirebaseMessagingRepository(
    firebaseMessagingProvider: FirebaseMessagingProvider(
      firebaseMessaging: FirebaseMessaging(),
    ),
  );

  runApp(
    BlocProvider(
      builder: (context) => AuthBloc(
        secureStorageRepository: _secureStorageRepository,
        authRepository: _authRepository,
      )..dispatch(AppStarted()),
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
            return _firebaseMessaging;
          }),
        ],
        child: App(),
      ),
    ),
  );
}
