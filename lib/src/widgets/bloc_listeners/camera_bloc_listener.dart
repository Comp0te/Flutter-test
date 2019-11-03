import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/routes/routes.dart';

class CameraBlocListener extends StatelessWidget with SnackBarMixin {
  final Widget child;

  const CameraBlocListener({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CameraBloc, CameraState>(
      condition: (prevState, curState) {
        return curState.photoPath != null ||
            (prevState.isVideoRecording && !curState.isVideoRecording);
      },
      listener: (context, state) {
        if (state.photoPath != null || state.videoPath != null) {
          Navigator.of(context).push(
            MainRoutes.cameraPreviewScreenRoute(
              context,
              BlocProvider.of<CameraBloc>(context),
            ),
          );
        }
      },
      child: child,
    );
  }
}
