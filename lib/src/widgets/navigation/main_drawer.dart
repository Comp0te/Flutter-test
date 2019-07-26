import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:flutter_app/src/utils/constants.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DrawerBloc _drawerBloc = BlocProvider.of<DrawerBloc>(context);

    return Drawer(
      child: BlocBuilder(
        bloc: _drawerBloc,
        builder: (BuildContext context, DrawerState state) {
          return Column(
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
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    selected: state.activeIndex == 0,
//                    enabled: state.activeIndex != 0,
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: state.activeIndex == 0
                        ? null
                        : () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, MainRouteNames.home);
                            _drawerBloc.dispatch(SetDrawerActiveIndex(
                              activeIndex: 0,
                            ));
                          },
                  ),
                  ListTile(
                    selected: state.activeIndex == 1,
//                    enabled: state.activeIndex != 1,
                    leading: Icon(Icons.storage),
                    title: Text('Database'),
                    onTap: state.activeIndex == 1
                        ? null
                        : () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, MainRouteNames.database);
                            _drawerBloc.dispatch(SetDrawerActiveIndex(
                              activeIndex: 1,
                            ));
                          },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// TODO: think about a more elegant implementation
