import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DBState extends Equatable {
  const DBState();

  @override
  List<Object> get props => [];
}

class DBInitial extends DBState {}

class DBLoading extends DBState {}

class DBLoaded extends DBState {}
