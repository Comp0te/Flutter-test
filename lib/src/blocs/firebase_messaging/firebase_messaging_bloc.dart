import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

class FirebaseMessagingBloc
    extends Bloc<FirebaseMessagingEvent, FirebaseMessagingState> {
  final FirebaseMessagingRepository _firebaseMessagingRepository;

  FirebaseMessagingBloc({
    @required FirebaseMessagingRepository firebaseMessagingRepository,
  })  : assert(firebaseMessagingRepository != null),
        _firebaseMessagingRepository = firebaseMessagingRepository;

  @override
  FirebaseMessagingState get initialState => FirebaseMessagingState();

  @override
  Stream<FirebaseMessagingState> mapEventToState(
    FirebaseMessagingEvent event,
  ) async* {
    if (event is RequestNotificationPermissions) {
      _firebaseMessagingRepository.requestPermissions();
    } else if (event is ConfigureFirebaseMessaging) {
      _firebaseMessagingRepository.configure(navigatorKey: event.navigatorKey);
    }
  }
}
