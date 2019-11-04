import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'src/app.dart';
import 'src/blocs/blocs.dart';
import 'src/data_providers/data_providers.dart';
import 'src/database/database.dart';
import 'src/helpers/helpers.dart';
import 'src/repositories/repositories.dart';

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
  final _firebaseMessagingRepository = FirebaseMessagingRepository(
    firebaseMessagingProvider: FirebaseMessagingProvider(
      firebaseMessaging: FirebaseMessaging(),
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
        BlocProvider<MainDrawerBloc>(
          builder: (context) => MainDrawerBloc(),
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
