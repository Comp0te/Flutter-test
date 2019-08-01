//import 'dart:async';
//import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/utils/camera_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class CameraVideoTab extends StatefulWidget {
  @override
  _CameraVideoTabState createState() => _CameraVideoTabState();
}

// TODO: Rework to single screen; Remove bottomTabNavigation;

class _CameraVideoTabState extends State<CameraVideoTab>
    with WidgetsBindingObserver {
//  CameraController cameraController;
  String imagePath;
  String videoPath;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: BlocBuilder(
        bloc: _cameraBloc,
        builder: (BuildContext context, CameraState state) {
          return GestureDetector(
            onLongPressStart: (_) {
              _cameraBloc.dispatch(StartVideoRecording());
            },
            onLongPressEnd: (_) {
              _cameraBloc.dispatch(StopVideoRecording());
            },
            child: FloatingActionButton(
              child: state.cameraController != null &&
                      state.cameraController.value.isRecordingVideo
                  ? Icon(Icons.videocam, size: 40)
                  : Icon(Icons.photo_camera, size: 40),
              onPressed: () {
                _cameraBloc.dispatch(TakePicture());
              },
            ),
          );
        },
      ),
      body: Column(
        children: <Widget>[
          _cameraPreviewWidget(),
//          _captureControlRowWidget(),
          _toggleAudioWidget(),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _cameraTogglesRowWidget(),
//                _thumbnailWidget(),
              ],
            ),
          ),
        ],
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
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: (state.cameraController == null ||
                        !state.cameraController.value.isInitialized)
                    ? Text('Tap a camera',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w900,
                        ))
                    : AspectRatio(
                        aspectRatio: state.cameraController.value.aspectRatio,
                        child: CameraPreview(state.cameraController),
                      ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: state.cameraController != null &&
                        state.cameraController.value.isRecordingVideo
                    ? Colors.redAccent
                    : Colors.grey,
                width: 3.0,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _toggleAudioWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        children: <Widget>[
          const Text('Enable Audio:'),
          BlocBuilder(
            bloc: _cameraBloc,
            builder: (BuildContext context, CameraState state) {
              return Switch(
                value: state.isAudioEnabled,
                onChanged: (bool value) {
                  _cameraBloc.dispatch(ToggleCameraAudio());
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// Display the thumbnail of the captured image or video.
//  Widget _thumbnailWidget() {
//    return Expanded(
//      child: Align(
//        alignment: Alignment.centerRight,
//        child: Row(
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            videoController == null && imagePath == null
//                ? Container()
//                : SizedBox(
//                    child: (videoController == null)
//                        ? Image.file(File(imagePath))
//                        : Container(
//                            child: Center(
//                              child: AspectRatio(
//                                  aspectRatio:
//                                      videoController.value.size != null
//                                          ? videoController.value.aspectRatio
//                                          : 1.0,
//                                  child: VideoPlayer(videoController)),
//                            ),
//                            decoration: BoxDecoration(
//                                border: Border.all(color: Colors.pink)),
//                          ),
//                    width: 64.0,
//                    height: 64.0,
//                  ),
//          ],
//        ),
//      ),
//    );
//  }

  Widget _cameraTogglesRowWidget() {
    return BlocBuilder(
      bloc: _cameraBloc,
      builder: (
        BuildContext context,
        CameraState state,
      ) {
        return state.cameras.isEmpty
            ? Text('No camera found')
            : Row(
                children: [
                  ...state.cameras.map((cameraDescription) {
                    return SizedBox(
                      width: 90.0,
                      child: RadioListTile<CameraDescription>(
                        title: Icon(CameraHelper.getCameraLensIcon(
                          cameraDescription.lensDirection,
                        )),
                        groupValue: state.cameraController?.description,
                        value: cameraDescription,
                        onChanged: state.cameraController != null &&
                                state.cameraController.value.isRecordingVideo
                            ? null
                            : (cameraDescription) {
                                _cameraBloc.dispatch(SelectCamera(
                                  cameraDescription: cameraDescription,
                                ));
                              },
                      ),
                    );
                  }),
                ],
              );
      },
    );
  }

//  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

//  void onNewCameraSelected(CameraDescription cameraDescription) async {
//    if (cameraController != null) {
//      await cameraController.dispose();
//    }
//    cameraController = CameraController(
//      cameraDescription,
//      ResolutionPreset.high,
////      enableAudio: enableAudio,
//    );
//
//    // If the cameraController is updated then update the UI.
//    cameraController.addListener(() {
//      if (mounted) setState(() {});
//      if (cameraController.value.hasError) {
//        showInSnackBar(
//            'Camera error ${cameraController.value.errorDescription}');
//      }
//    });
//
//    try {
//      await cameraController.initialize();
//    } on CameraException catch (e) {
//      _showCameraException(e);
//    }
//
//    if (mounted) {
//      setState(() {});
//    }
//  }

//  Future<String> startVideoRecording() async {
//    if (!cameraController.value.isInitialized) {
//      showInSnackBar('Error: select a camera first.');
//      return null;
//    }
//
//    final Directory extDir = await getApplicationDocumentsDirectory();
//    final String dirPath = '${extDir.path}/Movies/flutter_test';
//    await Directory(dirPath).create(recursive: true);
//    final String filePath = '$dirPath/${timestamp()}.mp4';
//
//    if (cameraController.value.isRecordingVideo) {
//      // A recording is already started, do nothing.
//      return null;
//    }
//
//    try {
//      videoPath = filePath;
//      await cameraController.startVideoRecording(filePath);
//    } on CameraException catch (e) {
//      _showCameraException(e);
//      return null;
//    }
//    return filePath;
//  }
//
//  Future<void> stopVideoRecording() async {
//    if (!cameraController.value.isRecordingVideo) {
//      return null;
//    }
//
//    try {
//      await cameraController.stopVideoRecording();
//    } on CameraException catch (e) {
//      _showCameraException(e);
//      return null;
//    }
//
////    await _startVideoPlayer();
//  }

//  Future<void> _startVideoPlayer() async {
//    final VideoPlayerController vcontroller =
//        VideoPlayerController.file(File(videoPath));
//    videoPlayerListener = () {
//      if (videoController != null && videoController.value.size != null) {
//        // Refreshing the state to update video player with the correct ratio.
//        if (mounted) setState(() {});
//        videoController.removeListener(videoPlayerListener);
//      }
//    };
//    vcontroller.addListener(videoPlayerListener);
//    await vcontroller.setLooping(true);
//    await vcontroller.initialize();
//    await videoController?.dispose();
//    if (mounted) {
//      setState(() {
//        imagePath = null;
//        videoController = vcontroller;
//      });
//    }
//    await vcontroller.play();
//  }

//  Future<String> takePicture() async {
//    if (!cameraController.value.isInitialized) {
//      showInSnackBar('Error: select a camera first.');
//      return null;
//    }
//    final Directory extDir = await getApplicationDocumentsDirectory();
//    final String dirPath = '${extDir.path}/Pictures/flutter_test';
//    await Directory(dirPath).create(recursive: true);
//    final String filePath = '$dirPath/${timestamp()}.jpg';
//
//    if (cameraController.value.isTakingPicture) {
//      // A capture is already pending, do nothing.
//      return null;
//    }
//
//    try {
//      await cameraController.takePicture(filePath);
//    } on CameraException catch (e) {
//      _showCameraException(e);
//      return null;
//    }
//    return filePath;
//  }
}
