import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VideoPlayerEvent extends Equatable {
  VideoPlayerEvent([List props = const []]) : super(props);
}

class InitVideoPlayerWithFile extends VideoPlayerEvent {
  final String videoPath;

  InitVideoPlayerWithFile({@required this.videoPath}) : super([videoPath]);
}

class PlayVideo extends VideoPlayerEvent {}

class PauseVideo extends VideoPlayerEvent {}