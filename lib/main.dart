import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'src/app.dart';
import 'src/utils/helpers/helpers.dart';
import 'src/repositories/repositories.dart';
import 'src/data_providers/data_providers.dart';
import 'src/blocs/blocs.dart';
import 'src/database/database.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final dio = DioInstance().dio;
  final _secureStorageRepository = SecureStorageRepository(
    storage: SecureStorageProvider(secureStorage: const FlutterSecureStorage()),
  );
  final _authRepository = AuthRepository(
    authApiProvider: AuthApiProvider(dio: dio),
  );
  final _postersRepository = PostersRepository(
    postersApiProvider: PostersApiProvider(dio: dio),
  );
  final _dbRepository = DBRepository(
    dbProvider: DBProvider(db: DBHelper().db),
  );
  final _imageStoreRepository = ImageStoreRepository(
    imageStoreProvider: ImageStoreProvider(),
  );
  final _cameraRepository = CameraRepository(
    cameraProvider: CameraProvider(),
  );
  final _firebaseMessaging = FirebaseMessagingRepository(
    firebaseMessagingProvider: FirebaseMessagingProvider(
      firebaseMessaging: FirebaseMessaging(),
    ),
  );

  runApp(
    BlocProvider(
      builder: (context) => AuthBloc(
        secureStorageRepository: _secureStorageRepository,
        authRepository: _authRepository,
      )..add(AppStarted()),
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
