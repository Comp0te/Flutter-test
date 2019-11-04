import 'package:flutter/material.dart';

import 'package:flutter_app/src/models/model.dart';

class DrawerItem extends StatelessWidget implements DrawerItemOptions {
  @override
  final Icon icon;
  @override
  final String title;
  @override
  final String routeName;
  final bool selected;

  const DrawerItem({
    @required this.title,
    @required this.routeName,
    this.selected = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      leading: icon,
      title: Text(title),
      onTap: selected
          ? null
          : () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, routeName);
            },
    );
  }
}
