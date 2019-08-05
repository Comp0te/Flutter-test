import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ImageStoreEvent extends Equatable {
  ImageStoreEvent([List props = const []]) : super(props);
}

class ImageStoreInit extends ImageStoreEvent {}

class GetImage extends ImageStoreEvent {
  final String url;

  GetImage({this.url})
      : super([url]);
}
