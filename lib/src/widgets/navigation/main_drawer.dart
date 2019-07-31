import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:flutter_app/src/utils/constants.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    final ActiveIndexBloc _activeIndexBloc = ActiveIndexBloc();

    return Drawer(
      child: BlocBuilder(
        bloc: _activeIndexBloc,
        builder: (BuildContext context, ActiveIndexState state) {
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
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: state.activeIndex == 0
                        ? null
                        : () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, MainRouteNames.home);
                            _activeIndexBloc.dispatch(SetActiveIndex(
                              activeIndex: 0,
                            ));
                          },
                  ),
                  ListTile(
                    selected: state.activeIndex == 1,
                    leading: Icon(Icons.storage),
                    title: Text('Database'),
                    onTap: state.activeIndex == 1
                        ? null
                        : () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, MainRouteNames.database);
                            _activeIndexBloc.dispatch(SetActiveIndex(
                              activeIndex: 1,
                            ));
                          },
                  ),
                  ListTile(
                    selected: state.activeIndex == 2,
                    leading: Icon(Icons.camera),
                    title: Text('Camera'),
                    onTap: state.activeIndex == 2
                        ? null
                        : () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, MainRouteNames.camera);
                            _activeIndexBloc.dispatch(SetActiveIndex(
                              activeIndex: 2,
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
