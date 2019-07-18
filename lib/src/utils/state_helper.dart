import 'package:meta/meta.dart';

abstract class StateHelper {
  static Map<String, T> updateEntities<T>({
    @required Map<String, T> stateEntities,
    @required List<T> eventEntitiesList,
  }) {
    if (eventEntitiesList == null) {
      return stateEntities;
    }

    Map<String, T> eventEntitiesMap = Map.fromIterable(
      eventEntitiesList,
      key: (entity) => entity.id.toString(),
      value: (entity) => entity,
    );
    Map<String, T> newEntities = Map.from(stateEntities)
      ..addAll(eventEntitiesMap);

    return newEntities;
  }

  static Map<String, T> deleteEntities<T>({
    @required Map<String, T> stateEntities,
    @required List<String> entitiesIds,
  }) {
    if (entitiesIds == null) {
      return stateEntities;
    }

    return Map.from(stateEntities)
      ..removeWhere((key, value) => entitiesIds.contains(key));
  }
}
