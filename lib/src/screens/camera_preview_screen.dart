import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_app/src/constants/constants.dart';

class CameraPreviewScreen extends StatefulWidget
    with OrientationMixin, ThemeMixin {
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
          color: widget.getTheme(context).accentIconTheme.color,
          size: 40,
        ),
        heroTag: HeroTag.cameraFAB,
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
                      color: widget.getTheme(context).backgroundColor,
                    ),
                    child: makePreview(state),
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
                  color: Colors.transparent,
                  child: Material(
                    color: widget.getTheme(context).accentColor,
                    elevation: 6,
                    shape: CircleBorder(),
                    child: IconButton(
                      iconSize: 40,
                      icon: Icon(
                        Icons.delete,
                        color: widget.getTheme(context).errorColor,
                        size: 40,
                      ),
                      onPressed: () {
                        if (state.photoPath != null) {
                          _cameraBloc.add(DeleteCameraFile(
                            path: state.photoPath,
                          ));
                        }

                        if (state.videoPath != null) {
                          _cameraBloc.add(DeleteCameraFile(
                            path: state.videoPath,
                          ));
                        }

                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makePreview(CameraState state) {
    if (state.photoPath != null) {
      return Image.file(
        File(state.photoPath),
        fit: BoxFit.contain,
      );
    }

    if (state.videoPath != null) {
      return CustomVideoPlayer(
        videoPath: state.videoPath,
      );
    }

    return Container();
  }
}
