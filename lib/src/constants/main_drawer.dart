import 'package:flutter/material.dart';

import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/models/model.dart';

const mainDrawerItemOptions = [
  DrawerItemOptions(
    title: 'Home',
    icon: Icon(Icons.home),
    routeName: MainRouteNames.home,
  ),
  DrawerItemOptions(
    title: 'Database',
    icon: Icon(Icons.storage),
    routeName: MainRouteNames.database,
  ),
  DrawerItemOptions(
    title: 'Camera',
    icon: Icon(Icons.camera),
    routeName: MainRouteNames.camera,
  ),
  DrawerItemOptions(
    title: 'Google maps',
    icon: Icon(Icons.map),
    routeName: MainRouteNames.googleMap,
  ),
];
