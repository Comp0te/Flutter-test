import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class PostersFetchEvent extends Equatable {
  PostersFetchEvent([List props = const []]) : super(props);
}

class PostersFetchRequestInit extends PostersFetchEvent {}

class PostersFetchRequest extends PostersFetchEvent {}

class PostersFetchRequestSuccess extends PostersFetchEvent {
  final PostersFetchResponse postersFetchResponse;

  PostersFetchRequestSuccess({@required this.postersFetchResponse})
      : super([postersFetchResponse]);
}

class PostersFetchRequestFailure extends PostersFetchEvent {
  final Exception error;

  PostersFetchRequestFailure({@required this.error}) : super([error]);
}
