import 'package:meta/meta.dart';
import 'package:flutter_app/src/utils/equatable_class.dart';
import 'package:video_player/video_player.dart';

@immutable
class VideoPlayerState extends EquatableClass {
  final VideoPlayerController videoPlayerController;
  final String videoPath;

  bool get isInitialized =>
      videoPlayerController != null && videoPlayerController.value.initialized;
  bool get isPlaying =>
      videoPlayerController != null && videoPlayerController.value.isPlaying;

  VideoPlayerState({
    this.videoPlayerController,
    this.videoPath,
  }) : super([
          videoPlayerController,
          videoPath,
        ]);

  factory VideoPlayerState.init() => VideoPlayerState();

  VideoPlayerState copyWith({
    VideoPlayerController videoPlayerController,
    String videoPath,
  }) {
    return VideoPlayerState(
      videoPlayerController:
          videoPlayerController ?? this.videoPlayerController,
      videoPath: videoPath ?? this.videoPath,
    );
  }
}
