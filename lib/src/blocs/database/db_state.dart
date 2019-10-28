import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
class DBState extends EquatableClass {
  final bool isDbLoading;

  DBState({
    @required this.isDbLoading,
  });

  factory DBState.init() => DBState(
        isDbLoading: false,
      );

  factory DBState.loading() => DBState(
        isDbLoading: true,
      );

  factory DBState.loaded() => DBState(
        isDbLoading: false,
      );

  @override
  List<Object> get props => [isDbLoading];
}
