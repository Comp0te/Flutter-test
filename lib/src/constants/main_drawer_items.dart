import 'package:flutter/material.dart';

import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/models/model.dart';

List<DrawerItemOptions> getMainDrawerItemOptions(BuildContext context) {
  return [
    DrawerItemOptions(
      title: S.of(context).onlinePosters,
      icon: const Icon(Icons.home),
      routeName: MainRouteNames.home,
    ),
    DrawerItemOptions(
      title: S.of(context).databasePosters,
      icon: const Icon(Icons.storage),
      routeName: MainRouteNames.database,
    ),
    DrawerItemOptions(
      title: S.of(context).gallery,
      icon: const Icon(Icons.camera),
      routeName: MainRouteNames.camera,
    ),
    DrawerItemOptions(
      title: S.of(context).googleMaps,
      icon: const Icon(Icons.map),
      routeName: MainRouteNames.googleMap,
    ),
  ];
}
