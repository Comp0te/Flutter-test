abstract class RequestInit {}

abstract class RequestSuccess<T> {
  final T response;

  RequestSuccess({this.response});
}

abstract class RequestFailure {
  final Exception error;

  RequestFailure({this.error});
}
