import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class PostersFetchState extends EquatableClass
    implements RequestPaginatedState<PostersFetchResponse> {
  @override
  final bool isLoadingFirstPage;
  @override
  final bool isLoadingNextPage;
  @override
  final PostersFetchResponse data;
  @override
  final Exception error;

  PostersFetchState({
    this.isLoadingFirstPage,
    this.isLoadingNextPage,
    this.data,
    this.error,
  }) : super([isLoadingFirstPage, isLoadingNextPage, data, error]);

  factory PostersFetchState.init() => PostersFetchState(
        isLoadingFirstPage: false,
        isLoadingNextPage: false,
      );

  @override
  bool get isSuccess => data != null;
  @override
  bool get isFailure => error != null;
  bool get hasNextPage => data.meta.page < data.meta.total;

  @override
  PostersFetchState copyWith({
    bool isLoadingFirstPage,
    bool isLoadingNextPage,
    PostersFetchResponse data,
    Exception error,
  }) {
    return PostersFetchState(
      isLoadingFirstPage: isLoadingFirstPage ?? this.isLoadingFirstPage,
      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}
