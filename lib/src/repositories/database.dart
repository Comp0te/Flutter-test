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

  Future<List<PosterNormalized>> getNormalizedPosters() async {
    final postersTable = await dbProvider.getPosters();

    final posters = postersTable.map<PosterNormalizedDB>((posterMap) {
      return PosterNormalizedDB.fromJson(posterMap);
    }).toList();

    final posterImagesTable = await dbProvider.getPosterImages();

    final posterImages = posterImagesTable.map<PosterImageDB>((posterImageMap) {
      return PosterImageDB.fromJson(posterImageMap);
    }).toList();

    return posters.map<PosterNormalized>((poster) {
      final images =
          posterImages.where((image) => image.posterId == poster.id).toList();
      return PosterNormalized(
        id: poster.id,
        ownerId: poster.ownerId,
        theme: poster.theme,
        text: poster.text,
        price: poster.price,
        currency: poster.currency,
        images: images.isNotEmpty ? images : null,
        contractPrice: poster.contractPrice == 1 ? true : false,
        location: poster.location,
        category: poster.category,
        activatedAt: poster.activatedAt,
        isActive: poster.isActive == 1 ? true : false,
      );
    }).toList();
  }
}
