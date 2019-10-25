import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

abstract class MainRouteNames {
  static const home = '/';
  static const database = '/database';
  static const camera = '/camera';
  static const cameraPreview = '/camera/preview';
  static const googleMap = '/googleMap';
}

abstract class MainRoutes {
  static PostersRepository _postersRepository(BuildContext context) =>
      RepositoryProvider.of<PostersRepository>(context);
  static DBRepository _dbRepository(BuildContext context) =>
      RepositoryProvider.of<DBRepository>(context);
  static ImageStoreRepository _imageStoreRepository(BuildContext context) =>
      RepositoryProvider.of<ImageStoreRepository>(context);
  static CameraRepository _cameraRepository(BuildContext context) =>
      RepositoryProvider.of<CameraRepository>(context);

  static AppStateBloc _appStateBloc(BuildContext context) =>
      BlocProvider.of<AppStateBloc>(context);

  static Route<HomeScreen> homeScreenRoute(BuildContext context) {
    return PageTransition(
      type: PageTransitionType.fade,
      alignment: Alignment.center,
      child: BlocProvider<PostersFetchBloc>(
        builder: (context) {
          return PostersFetchBloc(
            appStateBloc: _appStateBloc(context),
            postersRepository: _postersRepository(context),
            dbRepository: _dbRepository(context),
            imageStoreRepository: _imageStoreRepository(context),
          );
        },
        child: HomeScreen(),
      ),
    );
  }

  static Route<DatabaseScreen> databaseScreenRoute(BuildContext context) {
    return PageTransition(
      type: PageTransitionType.rightToLeft,
      alignment: Alignment.center,
      child: BlocProvider<DBBloc>(
        builder: (context) {
          return DBBloc(
            appStateBloc: _appStateBloc(context),
            dbRepository: _dbRepository(context),
          )..add(DBGetNormalizedPosters());
        },
        child: DatabaseScreen(),
      ),
    );
  }

  static Route<CameraScreen> cameraScreenRoute(BuildContext context) {
    return PageTransition(
      type: PageTransitionType.fade,
      alignment: Alignment.center,
      child: BlocProvider<CameraBloc>(
        builder: (context) {
          return CameraBloc(
            cameraRepository: _cameraRepository(context),
          )..add(InitCamera());
        },
        child: CameraScreen(),
      ),
    );
  }

  static Route<CameraPreviewScreen> cameraPreviewScreenRoute(
    BuildContext context,
    CameraBloc cameraBloc,
  ) {
    return PageTransition(
      type: PageTransitionType.leftToRight,
      alignment: Alignment.centerLeft,
      child: BlocProvider<CameraBloc>.value(
        value: cameraBloc,
        child: CameraPreviewScreen(),
      ),
    );
  }

  static Route<GoogleMapScreen> googleMapRoute(BuildContext context) {
    return PageTransition(
      type: PageTransitionType.fade,
      alignment: Alignment.center,
      child: GoogleMapScreen(),
    );
  }
}
