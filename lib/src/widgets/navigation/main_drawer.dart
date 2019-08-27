import 'package:flutter/material.dart';

import 'package:flutter_app/src/routes/main.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final _drawerItemOptions = <DrawerItemOptions>[
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Main Menu',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _drawerItemOptions.length,
              itemBuilder: (BuildContext context, int index) {
                return DrawerItem(
                  itemIndex: index,
                  title: _drawerItemOptions[index].title,
                  routeName: _drawerItemOptions[index].routeName,
                  icon: _drawerItemOptions[index].icon,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
