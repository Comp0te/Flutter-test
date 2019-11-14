import 'dart:io' as io;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ImageStoreState extends Equatable {
  const ImageStoreState();

  @override
  List<Object> get props => [];
}

class ImageStoreInitial extends ImageStoreState {}

class ImageStoreLoading extends ImageStoreState {}

class ImageStoreLoaded extends ImageStoreState {
  final io.File image;

  bool get hasImage => image != null;

  const ImageStoreLoaded({@required this.image});

  @override
  List<Object> get props => [image];
}
