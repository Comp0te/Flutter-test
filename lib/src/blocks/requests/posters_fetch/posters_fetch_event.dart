import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class PostersFetchEvent extends Equatable {
  PostersFetchEvent([List props = const []]) : super(props);
}

class PostersFetchRequestInit extends PostersFetchEvent {}

class PostersFetchFirstPageRequest extends PostersFetchEvent {}

class PostersFetchNextPageRequest extends PostersFetchEvent {
  final int page;

  PostersFetchNextPageRequest({
    this.page = 1,
  }) : super([page]);
}

class PostersFetchRequestSuccess extends PostersFetchEvent {
  final PostersFetchResponse postersFetchResponse;
  final bool isSuccessFirstRequest;

  PostersFetchRequestSuccess({
    @required this.postersFetchResponse,
    this.isSuccessFirstRequest = true,
  }) : super([postersFetchResponse, isSuccessFirstRequest]);
}

class PostersFetchRequestFailure extends PostersFetchEvent {
  final Exception error;
  final bool isErrorFirstRequest;

  PostersFetchRequestFailure({
    @required this.error,
    this.isErrorFirstRequest = true,
  }) : super([error, isErrorFirstRequest]);
}
