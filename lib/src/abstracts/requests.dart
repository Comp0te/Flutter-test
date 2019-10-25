import 'package:meta/meta.dart';

abstract class RequestInit {}

abstract class RequestSuccess<T> {
  final T response;

  RequestSuccess({this.response});
}

abstract class RequestFailure {
  final Exception error;

  RequestFailure({this.error});
}

abstract class RequestState<T> {
  final bool isLoading;
  final T data;
  final Exception error;

  bool get isSuccess => data != null;
  bool get isFailure => error != null;

  RequestState({this.isLoading, this.data, this.error});

  RequestState<T> copyWith({
    @required bool isLoading,
    T data,
    Exception error,
  }) {
    return this;
  }
}

abstract class RequestPaginatedState<T> {
  final bool isLoadingFirstPage;
  final bool isLoadingNextPage;
  final T data;
  final Exception error;

  RequestPaginatedState(
    this.isLoadingFirstPage,
    this.isLoadingNextPage,
    this.data,
    this.error,
  );

  bool get isSuccess => data != null;
  bool get isFailure => error != null;

  RequestPaginatedState<T> copyWith({
    bool isLoadingFirstPage,
    bool isLoadingNextPage,
    T data,
    Exception error,
  }) {
    return this;
  }
}
