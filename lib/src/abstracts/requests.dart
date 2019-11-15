abstract class RequestEvent {
  const RequestEvent();
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
