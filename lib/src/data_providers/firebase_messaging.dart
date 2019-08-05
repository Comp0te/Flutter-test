import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/utils/constants.dart';
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
      print(' =============== onResume ================= \n'
          '$message');
      if (message['route'] == MainRouteNames.database) {
        await navigatorKey.currentState.popAndPushNamed(
          MainRouteNames.database,
        );
      } else if (message['route'] == MainRouteNames.camera) {
        await navigatorKey.currentState.popAndPushNamed(
          MainRouteNames.database,
        );
      } else {
        await navigatorKey.currentState.popAndPushNamed(
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
