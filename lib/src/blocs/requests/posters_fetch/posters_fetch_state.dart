import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class PostersFetchState extends EquatableClass {
  final bool isLoadingFirstPage;
  final bool isLoadingNextPage;
  final PostersFetchResponse data;
  final Exception error;

  bool get isSuccess => data != null;
  bool get isFailure => error != null;
  bool get hasNextPage => data.meta.page < data.meta.total;

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

  PostersFetchState update({
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
