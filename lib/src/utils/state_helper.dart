import 'package:meta/meta.dart';

abstract class StateHelper {
  static Map<String, V> updateEntities<V>({
    @required Map<String, V> stateEntities,
    @required List<V> eventEntitiesList,
  }) {

    if (eventEntitiesList == null) {
      return stateEntities;
    }

    Map<String, V> eventEntitiesMap = Map.fromIterable(
      eventEntitiesList,
      key: (entity) => entity.id.toString(),
      value: (entity) => entity,
    );
    Map<String, V> newEntities = Map.from(stateEntities)
      ..addAll(eventEntitiesMap);

    return newEntities;
  }

  static Map<String, V> deleteEntities<V>({
    @required Map<String, V> stateEntities,
    @required List<String> entitiesIds,
  }) {
    if (entitiesIds == null) {
      return stateEntities;
    }

    return Map.from(stateEntities)
      ..removeWhere((key, value) => entitiesIds.contains(key));
  }
}
