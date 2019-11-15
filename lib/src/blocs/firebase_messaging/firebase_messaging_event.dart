import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FirebaseMessagingEvent extends Equatable {
  const FirebaseMessagingEvent();

  @override
  List<Object> get props => [];
}

class RequestNotificationPermissions extends FirebaseMessagingEvent {}

class GetToken extends FirebaseMessagingEvent {}

class ConfigureFirebaseMessaging extends FirebaseMessagingEvent {
  final GlobalKey<NavigatorState> navigatorKey;

  const ConfigureFirebaseMessaging({@required this.navigatorKey});

  @override
  List<Object> get props => [navigatorKey];
}
