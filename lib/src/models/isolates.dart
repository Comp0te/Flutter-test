import 'dart:io';

import 'package:meta/meta.dart';

class SaveImageIsolateMessage {
  File fileForSaving;
  File fileFromNetwork;

  SaveImageIsolateMessage({
    @required this.fileForSaving,
    @required this.fileFromNetwork,
  });
}
