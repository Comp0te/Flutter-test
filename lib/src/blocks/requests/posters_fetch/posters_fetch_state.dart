import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class PostersFetchState extends EquatableClass {
  final bool isLoading;
  final PostersFetchResponse data;
  final Exception error;

  bool get isSuccess => data != null;
  bool get isFailure => error != null;

  PostersFetchState({
    @required this.isLoading,
    this.data,
    this.error,
  }) : super([isLoading, data, error]);

  factory PostersFetchState.init() => PostersFetchState(isLoading: false);

  PostersFetchState update({
    @required bool isLoading,
    PostersFetchResponse data,
    Exception error,
  }) {
    return PostersFetchState(
      isLoading: isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}
