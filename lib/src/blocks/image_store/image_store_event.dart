import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ImageStoreEvent extends Equatable {
  ImageStoreEvent([List props = const []]) : super(props);
}

class ImageStoreInit extends ImageStoreEvent {}

class FetchImageFromNetwork extends ImageStoreEvent {
  final String url;

  FetchImageFromNetwork({this.url})
      : super([url]);
}

class SaveImageToStore extends ImageStoreEvent {
  final String url;

  SaveImageToStore({this.url})
      : super([url]);
}

class ReadImageFromStore extends ImageStoreEvent {
  final String url;

  ReadImageFromStore({this.url})
      : super([url]);
}
