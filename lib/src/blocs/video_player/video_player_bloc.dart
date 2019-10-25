import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_app/src/blocs/blocs.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  @override
  VideoPlayerState get initialState => VideoPlayerState.init();

  void dispose() {
    state.videoPlayerController.dispose();
    super.close();
  }

  @override
  Stream<VideoPlayerState> mapEventToState(VideoPlayerEvent event) async* {
    if (event is InitVideoPlayerWithFile) {
      yield* _mapInitVideoPlayerWithFileToState(event);
    } else if (event is PlayVideo) {
      yield* _mapPlayVideoToState(event);
    } else if (event is PauseVideo) {
      yield* _mapPauseVideoToState(event);
    }
  }

  Stream<VideoPlayerState> _mapInitVideoPlayerWithFileToState(
      InitVideoPlayerWithFile event) async* {
    try {
      final videoPlayerController = VideoPlayerController.file(
        File(event.videoPath),
      );

      await videoPlayerController.initialize();
      await videoPlayerController.setLooping(true);

      yield state.copyWith(
        videoPlayerController: videoPlayerController,
        videoPath: event.videoPath,
      );
    } catch (err) {
      print('--- initialize Video Player error --- $err');
    }
  }

  Stream<VideoPlayerState> _mapPlayVideoToState(PlayVideo event) async* {
    try {
      await state.videoPlayerController.play();

      yield state.copyWith(
          videoPlayerController: state.videoPlayerController);
    } catch (err) {
      print('--- initialize Video Player error --- $err');
    }
  }

  Stream<VideoPlayerState> _mapPauseVideoToState(PauseVideo event) async* {
    try {
      await state.videoPlayerController.pause();

      yield state.copyWith(
          videoPlayerController: state.videoPlayerController);
    } catch (err) {
      print('--- initialize Video Player error --- $err');
    }
  }
}
