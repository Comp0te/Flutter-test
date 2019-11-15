import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class PostersFetchState extends Equatable implements RequestState {
  const PostersFetchState();

  @override
  List<Object> get props => [];
}

class PostersFetchInitial extends PostersFetchState implements RequestInitial {}

class PostersFetchFirstRequestLoading extends PostersFetchState
    implements RequestLoading {}

class PostersFetchNextRequestLoading extends PostersFetchState
    implements RequestLoading {}

class PostersFetchSuccessful extends PostersFetchState
    implements RequestSuccessful<PostersFetchResponse> {
  @override
  final PostersFetchResponse data;

  bool get hasNextPage =>
      data?.meta != null ? data.meta.page < data.meta.total : false;

  const PostersFetchSuccessful({this.data});

  @override
  List<Object> get props => [data];
}

class PostersFetchFailed extends PostersFetchState implements RequestFailed {
  @override
  final Exception error;

  const PostersFetchFailed({this.error});

  @override
  List<Object> get props => [error];
}

//@immutable
//class PostersFetchState extends EquatableClass {
//  final bool isLoadingFirstPage;
//  final bool isLoadingNextPage;
//  final PostersFetchResponse data;
//  final Exception error;
//
//  PostersFetchState({
//    this.isLoadingFirstPage,
//    this.isLoadingNextPage,
//    this.data,
//    this.error,
//  });
//
//  factory PostersFetchState.init({bool isLoadingFirstPage = false}) {
//    return PostersFetchState(
//      isLoadingFirstPage: isLoadingFirstPage,
//      isLoadingNextPage: false,
//    );
//  }
//
//  bool get isLoading => isLoadingFirstPage || isLoadingNextPage;
//  bool get isRefreshing => isLoadingFirstPage;
//
//  bool get isSuccess => data != null;
//  bool get isFailure => error != null;
//
//  bool get hasNextPage =>
//      data?.meta != null ? data.meta.page < data.meta.total : false;
//
//  PostersFetchState copyWith({
//    bool isLoadingFirstPage,
//    bool isLoadingNextPage,
//    PostersFetchResponse data,
//    Exception error,
//  }) {
//    return PostersFetchState(
//      isLoadingFirstPage: isLoadingFirstPage ?? this.isLoadingFirstPage,
//      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
//      data: data ?? this.data,
//      error: error ?? this.error,
//    );
//  }
//
//  @override
//  List<Object> get props =>
//      [isLoadingFirstPage, isLoadingNextPage, data, error];
//}
