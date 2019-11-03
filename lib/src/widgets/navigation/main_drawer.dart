import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
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
            child: BlocBuilder<MainDrawerBloc, MainDrawerState>(
              builder: (context, state) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.drawerItemOptions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DrawerItem(
                      selected: state.activeDrawerIndex == index,
                      title: state.drawerItemOptions[index].title,
                      routeName: state.drawerItemOptions[index].routeName,
                      icon: state.drawerItemOptions[index].icon,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
