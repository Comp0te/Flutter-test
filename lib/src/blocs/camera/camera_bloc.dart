import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';

import 'package:flutter_app/src/blocs/blocs.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  @override
  CameraState get initialState => CameraState.init();

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is GetAvailableCameras) {
      try {
        final cameras = await availableCameras();

        yield currentState.update(
          cameras: cameras,
        );
      } catch (err) {
        print('--- availableCameras error --- $err');
      }
    } else if (event is ToggleCameraAudio) {
      yield currentState.update(isAudioEnabled: !currentState.isAudioEnabled);
    } else if (event is SelectCamera) {
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
  }
}

// TODO: finish logic