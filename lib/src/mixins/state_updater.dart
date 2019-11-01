import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

mixin StateUpdaterMixin on EquatableClass {
  Map<String, V> updateEntities<V>({
    @required Map<String, V> stateEntities,
    @required List<V> eventEntitiesList,
  }) {
    if (eventEntitiesList == null) {
      return stateEntities;
    }

    final eventEntitiesMap = Map.fromIterable(
      eventEntitiesList,
      key: (entity) => entity.id.toString(),
      value: (entity) => entity as V,
    );
    final newEntities = Map.of(stateEntities)..addAll(eventEntitiesMap);

    return newEntities;
  }

  Map<String, V> deleteEntities<V>({
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
