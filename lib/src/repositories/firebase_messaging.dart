import 'package:flutter/material.dart';
import 'package:flutter_app/src/data_providers/data_providers.dart';
import 'package:meta/meta.dart';

@immutable
class FirebaseMessagingRepository {
  final FirebaseMessagingProvider _firebaseMessagingProvider;

  FirebaseMessagingRepository({
    @required FirebaseMessagingProvider firebaseMessagingProvider,
  }) : _firebaseMessagingProvider = firebaseMessagingProvider;

  void requestPermissions() {
    _firebaseMessagingProvider.requestPermissions();
  }

  Future<String> getToken() async {
    return _firebaseMessagingProvider.getToken();
  }

  void configure({@required GlobalKey<NavigatorState> navigatorKey}) {
    _firebaseMessagingProvider.configure(navigatorKey: navigatorKey);
  }
}
