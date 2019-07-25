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
    var postersTable = await dbProvider.getPosters();

    List<PosterNormalized> posters =
        postersTable.map<PosterNormalized>((posterMap) {
      return PosterNormalized.fromJson(posterMap);
    }).toList();

    var posterImagesTable = await dbProvider.getPosterImages();

    List<PosterImageDB> posterImages =
        posterImagesTable.map<PosterImageDB>((posterImageMap) {
      return PosterImageDB.fromJson(posterImageMap);
    }).toList();

    return posters.map((poster) {
      var images =
          posterImages.where((image) => image.posterId == poster.id).toList();

      if (images.isNotEmpty) {
        return PosterNormalized(
          id: poster.id,
          ownerId: poster.ownerId,
          theme: poster.theme,
          text: poster.text,
          price: poster.price,
          currency: poster.currency,
          images: images,
          contractPrice: poster.contractPrice,
          location: poster.location,
          category: poster.category,
          activatedAt: poster.activatedAt,
          isActive: poster.isActive,
        );
      }

      return poster;
    }).toList();
  }
}
