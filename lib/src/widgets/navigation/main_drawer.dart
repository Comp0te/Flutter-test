import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer();

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<NavigationBloc>(context).add(SetMainDrawerItemOptions(
      options: getMainDrawerItemOptions(context),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                S.of(context).mainMenu,
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
            child: BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.mainDrawerItemOptions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DrawerItem(
                      selected: state.activeDrawerIndex == index,
                      title: state.mainDrawerItemOptions[index].title,
                      routeName: state.mainDrawerItemOptions[index].routeName,
                      icon: state.mainDrawerItemOptions[index].icon,
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
