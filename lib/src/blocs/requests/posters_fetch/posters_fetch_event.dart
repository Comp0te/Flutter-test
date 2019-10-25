import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class PostersFetchEvent extends Equatable {
  PostersFetchEvent([List props = const []]) : super(props);
}

class PostersFetchRequestInit extends PostersFetchEvent implements RequestInit {
}

class PostersFetchFirstPageRequest extends PostersFetchEvent {}

class PostersFetchNextPageRequest extends PostersFetchEvent {
  final int page;

  PostersFetchNextPageRequest({
    this.page = 1,
  }) : super([page]);
}

class PostersFetchRequestSuccess extends PostersFetchEvent
    implements RequestSuccess<PostersFetchResponse> {
  @override
  final PostersFetchResponse response;
  final bool isSuccessFirstRequest;

  PostersFetchRequestSuccess({
    @required this.response,
    this.isSuccessFirstRequest = true,
  }) : super([response, isSuccessFirstRequest]);
}

class PostersFetchRequestFailure extends PostersFetchEvent
    implements RequestFailure {
  @override
  final Exception error;
  final bool isErrorFirstRequest;

  PostersFetchRequestFailure({
    @required this.error,
    this.isErrorFirstRequest = true,
  }) : super([error, isErrorFirstRequest]);
}
