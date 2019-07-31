import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:flutter_app/src/screens/screens.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ActiveIndexBloc _drawerBloc = ActiveIndexBloc();

  List<Widget> tabScreens = [
    CameraPhotoTab(),
    CameraVideoTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _drawerBloc,
      builder: (
        BuildContext context,
        ActiveIndexState state,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Camera'),
            centerTitle: true,
          ),
          drawer: MainDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.photo_camera),
                title: Text('Photo'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.videocam),
                title: Text('Video'),
              ),
            ],
            currentIndex: state.activeIndex,
            selectedItemColor: Colors.blue,
            iconSize: 30,
            onTap: (int index) {
              _drawerBloc.dispatch(SetActiveIndex(activeIndex: index));
            },
          ),
          body: tabScreens[state.activeIndex],
        );
      },
    );
  }
}
