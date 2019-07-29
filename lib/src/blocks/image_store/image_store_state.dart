import 'dart:io' as Io;
import 'package:meta/meta.dart';

import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class ImageStoreState extends EquatableClass {
  final Io.File image;
  final bool isLoading;

  ImageStoreState({
    this.isLoading,
    this.image,
  }) : super([isLoading, image]);

  factory ImageStoreState.init() => ImageStoreState(
        isLoading: false,
      );

  factory ImageStoreState.loading() => ImageStoreState(
        isLoading: true,
      );

  factory ImageStoreState.loaded(Io.File image) => ImageStoreState(
        isLoading: false,
        image: image,
      );
}
