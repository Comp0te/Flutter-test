import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/utils/constants.dart';
import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/utils/helpers/camera_helper.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraBloc _cameraBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cameraBloc = BlocProvider.of<CameraBloc>(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _cameraBloc.state.take(1).listen((state) {
        state.cameraController?.dispose();
      });
    } else if (state == AppLifecycleState.resumed) {
      _cameraBloc.state.take(1).listen((state) {
        if (state.cameraController != null) {
          _cameraBloc.dispatch(
            SelectCamera(cameraDescription: state.cameras[0]),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onLongPressStart: (_) => _cameraBloc.dispatch(StartVideoRecording()),
        onLongPressUp: () => _cameraBloc.dispatch(StopVideoRecording()),
        child: FloatingActionButton(
          heroTag: HeroTag.cameraFAB,
          child: Icon(Icons.camera, size: 40),
          onPressed: () => _cameraBloc.dispatch(TakePicture()),
        ),
      ),
      body: BlocListener(
        bloc: _cameraBloc,
        condition: (CameraState prevState, CameraState curState) {
          return (prevState.photoPath != curState.photoPath &&
                  curState.photoPath != null) ||
              (prevState.isVideoRecording && !curState.isVideoRecording);
        },
        listener: (context, CameraState state) {
          if (state.photoPath != null || state.videoPath != null) {
            Navigator.pushNamed(context, MainRouteNames.cameraPreview,
                arguments: CameraPreviewScreenArgs(
                  photoPath: state.photoPath,
                  videoPath: state.videoPath,
                ));
          }
        },
        child: Stack(
          children: <Widget>[
            Column(children: <Widget>[
              _cameraPreviewWidget(),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.black),
                      child: Text(
                        'Tap for photo, hold for video',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
            Positioned(
              bottom: 30,
              right: 30,
              child: Hero(
                tag: HeroTag.cameraIconButton,
                child: Material(
                  shadowColor: Colors.blue,
                  color: Colors.transparent,
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(
                      Icons.settings_applications,
                      color: Colors.blue,
                      size: 40,
                    ),
                    onPressed: _onPressSettingsButton,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    return BlocBuilder(
      bloc: _cameraBloc,
      builder: (BuildContext context, CameraState state) {
        return Expanded(
          child: Container(
            child: Center(
              child: state.isInitialized
                  ? AspectRatio(
                      aspectRatio: state.cameraController.value.aspectRatio,
                      child: CameraPreview(state.cameraController),
                    )
                  : Spinner(),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: state.isVideoRecording
                    ? Colors.redAccent
                    : Colors.transparent,
                width: 3.0,
              ),
            ),
          ),
        );
      },
    );
  }

  void _onPressSettingsButton() {
    showModalBottomSheet(
      backgroundColor: Colors.blue.withOpacity(0.7),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _toggleAudioWidget(),
            _cameraTogglesRowWidget(),
          ],
        );
      },
    );
  }

  Widget _toggleAudioWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Audio:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        BlocBuilder(
          bloc: _cameraBloc,
          builder: (BuildContext context, CameraState state) {
            return Switch(
              activeColor: Colors.red,
              inactiveThumbColor: Colors.white,
              activeTrackColor: Colors.grey,
              inactiveTrackColor: Colors.grey,
              value: state.isAudioEnabled,
              onChanged: (bool value) {
                _cameraBloc.dispatch(ToggleCameraAudio());
              },
            );
          },
        ),
      ],
    );
  }

  Widget _cameraTogglesRowWidget() {
    return BlocBuilder(
      bloc: _cameraBloc,
      builder: (BuildContext context, CameraState state) {
        final toggles = state.cameras.map((cameraDescription) {
          return Padding(
            padding: EdgeInsets.only(right: 20),
            child: SizedBox(
              width: 90.0,
              child: RadioListTile<CameraDescription>(
                activeColor: Colors.red,
                title: Icon(
                  CameraHelper.getCameraLensIcon(
                    cameraDescription.lensDirection,
                  ),
                  color: Colors.white,
                  size: 30,
                ),
                groupValue: state.cameraController?.description,
                value: cameraDescription,
                onChanged: state.isVideoRecording
                    ? null
                    : (cameraDescription) {
                        _cameraBloc.dispatch(SelectCamera(
                          cameraDescription: cameraDescription,
                        ));
                      },
              ),
            ),
          );
        });

        return state.cameras.isEmpty
            ? Text('No camera found')
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [...toggles],
              );
      },
    );
  }
}
