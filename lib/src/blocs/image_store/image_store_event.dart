import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ImageStoreEvent extends Equatable {
  const ImageStoreEvent();
}

class ImageStoreInit extends ImageStoreEvent {
  @override
  List<Object> get props => [];
}

class GetImage extends ImageStoreEvent {
  final String url;

  GetImage({this.url});

  @override
  List<Object> get props => [url];
}
