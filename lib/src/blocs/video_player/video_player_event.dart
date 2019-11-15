import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object> get props => [];
}

class InitVideoPlayerWithFile extends VideoPlayerEvent {
  final String videoPath;

  InitVideoPlayerWithFile({@required this.videoPath});

  @override
  List<Object> get props => [videoPath];
}

class PlayVideo extends VideoPlayerEvent {}

class PauseVideo extends VideoPlayerEvent {}
