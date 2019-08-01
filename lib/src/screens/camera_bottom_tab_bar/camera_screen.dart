import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/screens/screens.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ActiveIndexBloc _activeTabBloc = ActiveIndexBloc();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final tabScreens = <Widget>[];

  @override
  void initState() {
    super.initState();
    tabScreens.addAll([
      CameraPhotoTab(
        scaffoldKey: _scaffoldKey,
      ),
      CameraVideoTab(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _activeTabBloc,
      builder: (
        BuildContext context,
        ActiveIndexState state,
      ) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
//            elevation: 20,
            child: state.activeIndex == 0
                ? Icon(Icons.photo_camera, size: 40)
                : Icon(Icons.videocam, size: 40),
            onPressed: () {}
          ),
          key: _scaffoldKey,
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
            iconSize: 20,
            onTap: (int index) {
              _activeTabBloc.dispatch(SetActiveIndex(activeIndex: index));
            },
          ),
          body: tabScreens[state.activeIndex],
        );
      },
    );
  }
}
