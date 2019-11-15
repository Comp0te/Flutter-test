import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
abstract class PostersFetchEvent extends Equatable implements RequestEvent {
  const PostersFetchEvent();

  @override
  List<Object> get props => [];
}

class PostersFetchFirstPageRequest extends PostersFetchEvent {}

class PostersFetchNextPageRequest extends PostersFetchEvent {
  final int page;

  PostersFetchNextPageRequest({
    this.page = 1,
  });

  @override
  List<Object> get props => [page];
}
