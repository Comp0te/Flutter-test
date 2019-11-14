import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ImageStoreEvent extends Equatable {
  const ImageStoreEvent();

  @override
  List<Object> get props => [];
}

class ImageStoreInit extends ImageStoreEvent {}

class GetImage extends ImageStoreEvent {
  final String url;

  const GetImage({this.url});

  @override
  List<Object> get props => [url];
}
