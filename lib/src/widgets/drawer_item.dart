import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';

class DrawerItemOptions {
  final String title;
  final Icon icon;
  final String routeName;

  DrawerItemOptions({
    @required this.icon,
    @required this.title,
    @required this.routeName,
  });
}

class DrawerItem extends StatelessWidget implements DrawerItemOptions {
  final int itemIndex;
  @override
  final Icon icon;
  @override
  final String title;
  @override
  final String routeName;

  DrawerItem({
    @required this.itemIndex,
    @required this.title,
    @required this.routeName,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final _activeIndexBloc = BlocProvider.of<ActiveIndexBloc>(context);

    return BlocBuilder<ActiveIndexBloc, ActiveIndexState>(
      bloc: _activeIndexBloc,
      builder: (BuildContext context, state) {
        return ListTile(
          selected: state.activeIndex == itemIndex,
          leading: icon,
          title: Text(title),
          onTap: state.activeIndex == itemIndex
              ? null
              : () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, routeName);
                },
        );
      },
    );
  }
}
