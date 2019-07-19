import 'dart:async';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/data_providers/data_providers.dart';
import 'package:flutter_app/src/models/model.dart';

class PostersRepository {
  final PostersApiProvider postersApiProvider;

  PostersRepository({@required this.postersApiProvider})
      : assert(postersApiProvider != null);

  Future<PostersFetchResponse> fetchPosters() async {
    return await postersApiProvider.fetchPosters();
  }
}
