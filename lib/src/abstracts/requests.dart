abstract class RequestInit {}

abstract class RequestSuccess<T> {
  final T response;

  RequestSuccess({this.response});
}

abstract class RequestFailure {
  final Exception error;

  RequestFailure({this.error});
}

abstract class RequestState {
  const RequestState();
}

abstract class RequestInitial extends RequestState {}

abstract class RequestLoading extends RequestState {}

abstract class RequestSuccessful<T> extends RequestState {
  final T data;

  const RequestSuccessful({this.data});
}

abstract class RequestFailed extends RequestState {
  final Exception error;

  const RequestFailed({this.error});
}
