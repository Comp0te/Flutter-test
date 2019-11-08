import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
class GoogleLoginState extends EquatableClass
    implements RequestState<AuthResponse> {
  @override
  final bool isLoading;
  @override
  final AuthResponse data;
  @override
  final Exception error;

  GoogleLoginState({
    @required this.isLoading,
    this.data,
    this.error,
  });

  @override
  bool get isRefreshing => isLoading;
  @override
  bool get isSuccess => data != null;
  @override
  bool get isFailure => error != null;

  factory GoogleLoginState.init({bool isLoading = false}) =>
      GoogleLoginState(isLoading: isLoading);

  @override
  GoogleLoginState copyWith({
    @required bool isLoading,
    AuthResponse data,
    Exception error,
  }) {
    return GoogleLoginState(
      isLoading: isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [isLoading, data, error];
}
