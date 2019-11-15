import 'package:meta/meta.dart';
import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:video_player/video_player.dart';

enum VideoPlayerErrorsType { common }

@immutable
class VideoPlayerState extends EquatableClass {
  final VideoPlayerController videoPlayerController;
  final String videoPath;
  final VideoPlayerErrorsType errorType;

  bool get isInitialized =>
      videoPlayerController != null && videoPlayerController.value.initialized;
  bool get isPlaying =>
      videoPlayerController != null && videoPlayerController.value.isPlaying;
  bool get hasError => errorType != null;

  VideoPlayerState({
    this.videoPlayerController,
    this.videoPath,
    this.errorType,
  });

  factory VideoPlayerState.init() => VideoPlayerState();

  VideoPlayerState copyWith({
    VideoPlayerController videoPlayerController,
    String videoPath,
    VideoPlayerErrorsType errorType,
  }) {
    return VideoPlayerState(
      videoPlayerController:
          videoPlayerController ?? this.videoPlayerController,
      videoPath: videoPath ?? this.videoPath,
      errorType: errorType ?? this.errorType,
    );
  }

  @override
  List<Object> get props => [videoPlayerController, videoPath, errorType];
}
