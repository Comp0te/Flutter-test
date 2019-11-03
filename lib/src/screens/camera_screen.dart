import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/helpers/helpers.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class CameraScreen extends StatefulWidget with OrientationMixin {
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
    _cameraBloc = BlocProvider.of<CameraBloc>(context)..add(InitCamera());
    widget.setOnlyPortraitUP();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.setAllOrientations();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _cameraBloc.state.cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      final state = _cameraBloc.state;

      if (state.cameraController != null) {
        _cameraBloc.add(
          SelectCamera(cameraDescription: state.cameras[0]),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onLongPressStart: (_) => _cameraBloc.add(StartVideoRecording()),
        onLongPressUp: () => _cameraBloc.add(StopVideoRecording()),
        child: FloatingActionButton(
          heroTag: HeroTag.cameraFAB,
          child: const Icon(Icons.camera, size: 40),
          onPressed: () => _cameraBloc.add(TakePicture()),
        ),
      ),
      body: CameraBlocListener(
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
    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        return Expanded(
          child: Container(
            child: Center(
              child: state.isInitialized
                  ? AspectRatio(
                      aspectRatio: state.cameraController.value.aspectRatio,
                      child: CameraPreview(state.cameraController),
                    )
                  : const Spinner(),
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
    showModalBottomSheet<void>(
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
        BlocBuilder<CameraBloc, CameraState>(
          bloc: _cameraBloc,
          builder: (context, state) {
            return Switch(
              activeColor: Colors.red,
              inactiveThumbColor: Colors.white,
              activeTrackColor: Colors.grey,
              inactiveTrackColor: Colors.grey,
              value: state.isAudioEnabled,
              onChanged: (bool value) {
                _cameraBloc.add(ToggleCameraAudio());
              },
            );
          },
        ),
      ],
    );
  }

  Widget _cameraTogglesRowWidget() {
    return BlocBuilder<CameraBloc, CameraState>(
      bloc: _cameraBloc,
      builder: (context, state) {
        final toggles = state.cameras.map((cameraDescription) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
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
                        _cameraBloc.add(SelectCamera(
                          cameraDescription: cameraDescription,
                        ));
                      },
              ),
            ),
          );
        });

        return state.cameras.isEmpty
            ? const Text('No camera found')
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [...toggles],
              );
      },
    );
  }
}
