import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/helpers/helpers.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class CameraScreen extends StatefulWidget with OrientationMixin, ThemeMixin {
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
    return SafeArea(
      child: Scaffold(
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
                _cameraPreviewWidget(context),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              widget.getTheme(context).scaffoldBackgroundColor,
                        ),
                        child: Text(
                          S.of(context).cameraHelperText,
                          textAlign: TextAlign.center,
                          style: widget.getTextTheme(context).caption,
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
                    color: widget.getTheme(context).accentColor,
                    elevation: 6,
                    shape: CircleBorder(),
                    child: IconButton(
                      color: widget.getTheme(context).accentIconTheme.color,
                      iconSize: 30,
                      icon: Icon(
                        Icons.settings_applications,
                      ),
                      onPressed: _makeOnPressSettingsButton(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cameraPreviewWidget(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        return Expanded(
          child: Container(
            child: Center(
              child: state.isInitialized
                  ? AspectRatio(
                      aspectRatio: state.cameraController.value.aspectRatio,
                      child: Stack(
                        children: [
                          CameraPreview(state.cameraController),
                          Positioned(
                            // TODO: add video recording counter
                            left: 15,
                            top: 15,
                            child: AnimatedOpacity(
                              duration: const Duration(seconds: 1),
                              opacity: state.isVideoRecording ? 1 : 0,
                              curve: Curves.bounceInOut,
                              child: Icon(
                                Icons.videocam,
                                color: widget.getTheme(context).accentColor,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Spinner(),
            ),
          ),
        );
      },
    );
  }

  VoidCallback _makeOnPressSettingsButton(BuildContext context) {
    return () {
      showModalBottomSheet<void>(
        backgroundColor:
            widget.getTheme(context).bottomSheetTheme.backgroundColor,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _toggleAudioWidget(context),
              _cameraTogglesRowWidget(context),
            ],
          );
        },
      );
    };
  }

  Widget _toggleAudioWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          '${S.of(context).audio}:',
          style: widget.getTheme(context).textTheme.body1,
        ),
        BlocBuilder<CameraBloc, CameraState>(
          bloc: _cameraBloc,
          builder: (context, state) {
            return Switch.adaptive(
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

  Widget _cameraTogglesRowWidget(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraState>(
      bloc: _cameraBloc,
      builder: (context, state) {
        final toggles = state.cameras.map((cameraDescription) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              width: 90.0,
              child: RadioListTile<CameraDescription>(
                title: Icon(
                  CameraHelper.getCameraLensIcon(
                    cameraDescription.lensDirection,
                  ),
                  color: widget.getColorScheme(context).onSurface,
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
            ? Text(
                S.of(context).noCameraFound,
                style: widget.getTextTheme(context).body1,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [...toggles],
              );
      },
    );
  }
}
