import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CameraRepository _cameraRepository;

  CameraBloc({
    @required CameraRepository cameraRepository,
  })  : assert(cameraRepository != null),
        _cameraRepository = cameraRepository;

  @override
  CameraState get initialState => CameraState.init();

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is GetAvailableCameras) {
      yield* _mapGetAvailableCamerasToState(event);
    } else if (event is ToggleCameraAudio) {
      yield* _mapToggleCameraAudioToState(event);
    } else if (event is SelectCamera) {
      yield* _mapSelectCameraToState(event);
    } else if (event is TakePicture) {
      yield* _mapTakePictureToState(event);
    } else if (event is StartVideoRecording) {
      yield* _mapStartVideoRecordingToState(event);
    } else if (event is StopVideoRecording) {
      yield* _mapStopVideoRecordingToState(event);
    }
  }

  Stream<CameraState> _mapGetAvailableCamerasToState(
    GetAvailableCameras event,
  ) async* {
    try {
      final cameras = await availableCameras();

      yield currentState.update(
        cameras: cameras,
      );
    } catch (err) {
      print('--- availableCameras error --- $err');
    }
  }

  Stream<CameraState> _mapToggleCameraAudioToState(
    ToggleCameraAudio event,
  ) async* {
    yield currentState.update(isAudioEnabled: !currentState.isAudioEnabled);
  }

  Stream<CameraState> _mapSelectCameraToState(
    SelectCamera event,
  ) async* {
    try {
      if (currentState.cameraController != null) {
        await currentState.cameraController.dispose();
      }

      final newController = CameraController(
        event.cameraDescription,
        ResolutionPreset.high,
        enableAudio: currentState.isAudioEnabled,
      );
      await newController.initialize();

      yield currentState.update(
        cameraController: newController,
      );
    } catch (err) {
      print('camera select error - $err');
    }
  }

  Stream<CameraState> _mapTakePictureToState(TakePicture event) async* {
    final photoPath = await _cameraRepository.takePicture(
      currentState.cameraController,
    );

    yield currentState.update(photoPath: photoPath);
  }

  Stream<CameraState> _mapStartVideoRecordingToState(
    StartVideoRecording event,
  ) async* {
    final videoPath = await _cameraRepository.startRecordingVideo(
      currentState.cameraController,
    );

    yield currentState.update(videoPath: videoPath);
  }

  Stream<CameraState> _mapStopVideoRecordingToState(
    StopVideoRecording event,
  ) async* {
    await _cameraRepository.stopRecordingVideo(
      currentState.cameraController,
    );

    yield currentState.update();
  }
}
