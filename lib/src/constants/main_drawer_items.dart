import 'package:flutter/material.dart';

import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/models/model.dart';

List<DrawerItemOptions> getMainDrawerItemOptions(BuildContext context) {
  return [
    DrawerItemOptions(
      title: S.of(context).onlinePosters,
      icon: Icon(Icons.home),
      routeName: MainRouteNames.home,
    ),
    DrawerItemOptions(
      title: S.of(context).databasePosters,
      icon: Icon(Icons.storage),
      routeName: MainRouteNames.database,
    ),
    DrawerItemOptions(
      title: S.of(context).gallery,
      icon: Icon(Icons.camera),
      routeName: MainRouteNames.camera,
    ),
    DrawerItemOptions(
      title: S.of(context).googleMaps,
      icon: Icon(Icons.map),
      routeName: MainRouteNames.googleMap,
    ),
  ];
}
