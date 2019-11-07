import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
class FacebookLoginState extends EquatableClass
    implements RequestState<AuthResponse> {
  @override
  final bool isLoading;
  @override
  final AuthResponse data;
  @override
  final Exception error;

  FacebookLoginState({
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

  factory FacebookLoginState.init({bool isLoading = false}) =>
      FacebookLoginState(isLoading: isLoading);

  @override
  FacebookLoginState copyWith({
    @required bool isLoading,
    AuthResponse data,
    Exception error,
  }) {
    return FacebookLoginState(
      isLoading: isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [isLoading, data, error];
}
