import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class RegisterState extends EquatableClass
    implements RequestState<AuthResponse> {
  @override
  final bool isLoading;
  @override
  final AuthResponse data;
  @override
  final Exception error;

  RegisterState({
    @required this.isLoading,
    this.data,
    this.error,
  });

  @override
  bool get isSuccess => data != null;
  @override
  bool get isFailure => error != null;

  factory RegisterState.init() => RegisterState(isLoading: false);

  @override
  RegisterState copyWith({
    @required bool isLoading,
    AuthResponse data,
    Exception error,
  }) {
    return RegisterState(
      isLoading: isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [isLoading, data, error];

}
