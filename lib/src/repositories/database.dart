import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/data_providers/data_providers.dart';

class DBRepository {

  final DBProvider dbProvider;

  DBRepository({
    @required this.dbProvider,
  }) : assert(dbProvider != null);

  Future insertPosters(List<PosterNormalized> posters) async {
    await dbProvider.insertPosters(posters);
  }

  Future insertUsers(List<User> users) async {
    await dbProvider.insertUsers(users);
  }

  Future insertPosterImages(List<PosterNormalized> posters) async {
    await dbProvider.insertPosterImages(posters);
  }
}
