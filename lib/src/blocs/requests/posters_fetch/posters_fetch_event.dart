import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class PostersFetchEvent extends Equatable {
  const PostersFetchEvent();
}

class PostersFetchRequestInit extends PostersFetchEvent implements RequestInit {
  @override
  List<Object> get props => [];
}

class PostersFetchFirstPageRequest extends PostersFetchEvent {
  @override
  List<Object> get props => [];
}

class PostersFetchNextPageRequest extends PostersFetchEvent {
  final int page;

  PostersFetchNextPageRequest({
    this.page = 1,
  });

  @override
  List<Object> get props => [page];
}

class PostersFetchRequestSuccess extends PostersFetchEvent
    implements RequestSuccess<PostersFetchResponse> {
  @override
  final PostersFetchResponse response;
  final bool isSuccessFirstRequest;

  PostersFetchRequestSuccess({
    @required this.response,
    this.isSuccessFirstRequest = true,
  });

  @override
  List<Object> get props => [response, isSuccessFirstRequest];
}

class PostersFetchRequestFailure extends PostersFetchEvent
    implements RequestFailure {
  @override
  final Exception error;
  final bool isErrorFirstRequest;

  PostersFetchRequestFailure({
    @required this.error,
    this.isErrorFirstRequest = true,
  });

  @override
  List<Object> get props => [error, isErrorFirstRequest];
}
