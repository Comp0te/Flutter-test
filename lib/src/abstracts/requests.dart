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

  bool get isRefreshing;
  bool get isSuccess => data != null;
  bool get isFailure => error != null;

  RequestState({this.isLoading, this.data, this.error});

  RequestState<T> copyWith() {
    return this;
  }
}

abstract class RequestPaginatedState<T> extends RequestState<T> {
  final bool isLoadingFirstPage;
  final bool isLoadingNextPage;

  RequestPaginatedState(
    this.isLoadingFirstPage,
    this.isLoadingNextPage,
    T data,
      Exception error,) : super(
    data: data,
    error: error,
    isLoading: isLoadingFirstPage || isLoadingNextPage,
  );
}
