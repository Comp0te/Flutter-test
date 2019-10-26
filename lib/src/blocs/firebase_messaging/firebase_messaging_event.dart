import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FirebaseMessagingEvent extends Equatable {
  const FirebaseMessagingEvent();
}

class RequestNotificationPermissions extends FirebaseMessagingEvent {
  @override
  List<Object> get props => [];
}

class GetToken extends FirebaseMessagingEvent {
  @override
  List<Object> get props => [];
}

class ConfigureFirebaseMessaging extends FirebaseMessagingEvent {
  final GlobalKey<NavigatorState> navigatorKey;

  ConfigureFirebaseMessaging({@required this.navigatorKey});

  @override
  List<Object> get props => [navigatorKey];
}
