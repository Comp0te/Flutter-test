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
    if (event is InitCamera) {
      yield* _mapInitCameraToState(event);
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
    } else if (event is DeleteCameraFile) {
      yield* _mapDeleteCameraFileToState(event);
    } else if (event is ResetCameraFiles) {
      yield* _mapResetCameraFilesToState(event);
    }
  }

  Stream<CameraState> _mapInitCameraToState(InitCamera event) async* {
    try {
      final cameras = await availableCameras();

      final backCameraList = cameras
          .where((camera) => camera.lensDirection == CameraLensDirection.back)
          .toList();

      final controller = CameraController(
        backCameraList.isNotEmpty ? backCameraList[0] : cameras[0],
        ResolutionPreset.high,
        enableAudio: state.isAudioEnabled,
      );

      await controller.initialize();

      yield state.copyWith(
        cameraController: controller,
        cameras: cameras,
      );
    } catch (err) {
      print('--- availableCameras error --- $err');
    }
  }

  Stream<CameraState> _mapToggleCameraAudioToState(
    ToggleCameraAudio event,
  ) async* {
    yield state.copyWith(isAudioEnabled: !state.isAudioEnabled);

    add(SelectCamera(
      cameraDescription: state.cameraController.description,
    ));
  }

  Stream<CameraState> _mapSelectCameraToState(
    SelectCamera event,
  ) async* {
    try {
      if (state.cameraController != null) {
        await state.cameraController.dispose();
      }

      final newController = CameraController(
        event.cameraDescription,
        ResolutionPreset.high,
        enableAudio: state.isAudioEnabled,
      );
      await newController.initialize();

      yield state.copyWith(
        cameraController: newController,
      );
    } catch (err) {
      print('camera select error - $err');
    }
  }

  Stream<CameraState> _mapTakePictureToState(TakePicture event) async* {
    final photoPath = await _cameraRepository.takePicture(
      state.cameraController,
    );

    yield state.copyWith(photoPath: photoPath);
  }

  Stream<CameraState> _mapStartVideoRecordingToState(
    StartVideoRecording event,
  ) async* {
    final videoPath = await _cameraRepository.startRecordingVideo(
      state.cameraController,
    );

    yield state.copyWith(
      videoPath: videoPath,
      isVideoRecording: true,
    );
  }

  Stream<CameraState> _mapStopVideoRecordingToState(
    StopVideoRecording event,
  ) async* {
    await _cameraRepository.stopRecordingVideo(
      state.cameraController,
    );

    yield state.copyWith(isVideoRecording: false);
  }

  Stream<CameraState> _mapDeleteCameraFileToState(
    DeleteCameraFile event,
  ) async* {
    try {
      await _cameraRepository.deleteFile(
        path: event.path,
      );
    } catch (e) {
      print('error --- delete camera file = $e');
    }

    yield state.resetCameraFiles();
  }

  Stream<CameraState> _mapResetCameraFilesToState(
    ResetCameraFiles event,
  ) async* {
    yield state.resetCameraFiles();
  }
} // TODO add all new features
