import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

class SQFLiteRepository implements DatabaseRepository {
  @override
  DatabaseProvider databaseProvider;

  SQFLiteRepository({
    @required this.databaseProvider,
  }) : assert(databaseProvider != null);

  @override
  Future insertPosters(List<PosterNormalized> posters) async {
    await databaseProvider.insertPosters(posters);
  }

  @override
  Future insertUsers(List<User> users) async {
    await databaseProvider.insertUsers(users);
  }

  @override
  Future insertPosterImages(List<PosterNormalized> posters) async {
    await databaseProvider.insertPosterImages(posters);
  }

  @override
  Future<List<PosterNormalized>> getNormalizedPosters() async {
    final postersTable = await databaseProvider.getPosters();

    final posters = postersTable.map<PosterNormalizedDB>((posterMap) {
      return PosterNormalizedDB.fromJson(posterMap);
    }).toList();

    final posterImagesTable = await databaseProvider.getPosterImages();

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
