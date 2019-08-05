import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FirebaseMessagingEvent extends Equatable {
  FirebaseMessagingEvent([List props = const []]) : super(props);
}

class RequestNotificationPermissions extends FirebaseMessagingEvent {}

class GetToken extends FirebaseMessagingEvent {}

class ConfigureFirebaseMessaging extends FirebaseMessagingEvent {
  final GlobalKey<NavigatorState> navigatorKey;

  ConfigureFirebaseMessaging({@required this.navigatorKey})
      : super([navigatorKey]);
}
