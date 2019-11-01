import 'package:flutter/material.dart';

class DrawerItemOptions {
  final String title;
  final Icon icon;
  final String routeName;

  const DrawerItemOptions({
    @required this.icon,
    @required this.title,
    @required this.routeName,
  });
}
