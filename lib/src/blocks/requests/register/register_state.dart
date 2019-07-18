import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class RegisterState extends EquatableClass {
  final bool isLoading;
  final AuthResponse data;
  final Exception error;

  bool get isSuccess => data != null;
  bool get isFailure => error != null;

  RegisterState({
    @required this.isLoading,
    this.data,
    this.error,
  }) : super([isLoading, data, error]);

  factory RegisterState.init() => RegisterState(isLoading: false);

  RegisterState update({
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
}
