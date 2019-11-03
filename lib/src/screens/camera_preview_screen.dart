import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_app/src/constants/constants.dart';

class CameraPreviewScreen extends StatefulWidget with OrientationMixin {
  @override
  _CameraPreviewScreenState createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  CameraBloc _cameraBloc;

  @override
  void initState() {
    super.initState();
    _cameraBloc = BlocProvider.of<CameraBloc>(context);
    BackButtonInterceptor.add(androidBackHandler);
    widget.setAllOrientations();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(androidBackHandler);
    widget.setOnlyPortraitUP();
    super.dispose();
  }

  bool androidBackHandler(bool stopDefaultButtonEvent) {
    _cameraBloc.add(ResetCameraFiles());
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_photo_alternate,
          color: Colors.white,
          size: 40,
        ),
        heroTag: HeroTag.cameraFAB,
        backgroundColor: Colors.green,
        onPressed: () {
          _cameraBloc.add(ResetCameraFiles());
          Navigator.of(context).pop();
        },
      ),
      body: BlocBuilder<CameraBloc, CameraState>(
        builder: (context, state) => Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: state.photoPath != null
                        ? Image.file(
                            File(state.photoPath),
                            fit: BoxFit.contain,
                          )
                        : CustomVideoPlayer(
                            videoPath: state.videoPath,
                          ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 80,
              right: 17,
              child: Hero(
                tag: HeroTag.cameraIconButton,
                child: Material(
                  shadowColor: Colors.blue,
                  color: Colors.transparent,
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 40,
                    ),
                    onPressed: () {
                      _cameraBloc.add(DeleteCameraFile(
                        path: state.photoPath != null
                            ? state.photoPath
                            : state.videoPath,
                      ));
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
