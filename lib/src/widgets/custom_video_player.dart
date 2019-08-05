import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoPath;

  const CustomVideoPlayer({Key key, @required this.videoPath})
      : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer>
    with SingleTickerProviderStateMixin {
  VideoPlayerBloc _videoPlayerBloc;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _videoPlayerBloc = VideoPlayerBloc()
      ..dispatch(InitVideoPlayerWithFile(
        videoPath: widget.videoPath,
      ));
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BlocBuilder(
          bloc: _videoPlayerBloc,
          builder: (context, VideoPlayerState state) {
            return Center(
              child: state.isInitialized
                  ? AspectRatio(
                      aspectRatio:
                          state.videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(state.videoPlayerController),
                    )
                  : Spinner(),
            );
          },
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: BlocBuilder(
            bloc: _videoPlayerBloc,
            builder: (context, VideoPlayerState state) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(
                    width: 2,
                    color: Colors.white,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue,
                      blurRadius: 4,
                    )
                  ],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 40,
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: _animationController,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (state.isPlaying) {
                      _videoPlayerBloc.dispatch(PauseVideo());
                      _animationController.reverse();
                    } else {
                      _videoPlayerBloc.dispatch(PlayVideo());
                      _animationController.forward();
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
