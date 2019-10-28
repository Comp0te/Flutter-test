import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:meta/meta.dart';

@immutable
class FirebaseMessagingProvider {
  final FirebaseMessaging _firebaseMessaging;

  FirebaseMessagingProvider({@required FirebaseMessaging firebaseMessaging})
      : _firebaseMessaging = firebaseMessaging;

  void requestPermissions() {
    _firebaseMessaging.requestNotificationPermissions();
  }

  Future<String> getToken() async {
    return _firebaseMessaging.getToken();
  }

  void configure({@required GlobalKey<NavigatorState> navigatorKey}) {
    _firebaseMessaging.configure(
      onResume: _makeOnResume(navigatorKey),
      onLaunch: _makeOnLaunch(navigatorKey),
      onMessage: _makeOnMessage(navigatorKey),
    );
  }

  MessageHandler _makeOnResume(GlobalKey<NavigatorState> navigatorKey) {
    return (Map<String, dynamic> message) async {
      final data = message['data'] as Map<String, dynamic> ?? message;

      print(' =============== onResume ================= \n'
          '$message');
      if (data['route'] == MainRouteNames.database) {
        await navigatorKey.currentState.pushReplacementNamed(
          MainRouteNames.database,
        );
      } else if (data['route'] == MainRouteNames.camera) {
        await navigatorKey.currentState.pushReplacementNamed(
          MainRouteNames.camera,
        );
      } else {
        await navigatorKey.currentState.pushReplacementNamed(
          MainRouteNames.home,
        );
      }
    };
  }

  MessageHandler _makeOnLaunch(GlobalKey<NavigatorState> navigatorKey) {
    return (Map<String, dynamic> message) async {
      print(' =============== onLaunch ================= \n'
          '$message');
    };
  }

  MessageHandler _makeOnMessage(GlobalKey<NavigatorState> navigatorKey) {
    return (Map<String, dynamic> message) async {
      print(' =============== onMessage ================= \n'
          '$message');
    };
  }
}
