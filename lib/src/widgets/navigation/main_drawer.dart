import 'package:flutter/material.dart';
import 'package:flutter_app/src/utils/constants.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
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
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            selected: true,
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, MainRouteNames.home);
            },
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Database'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, MainRouteNames.database);
            },
          ),
        ],
      ),
    );
  }
}
