import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class ImageStoreBloc extends Bloc<ImageStoreEvent, ImageStoreState> {
  final ImageDatabaseRepository _imageDatabaseRepository;

  ImageStoreBloc({
    @required ImageStoreRepository imageDatabaseRepository,
  })  : assert(imageDatabaseRepository != null),
        _imageDatabaseRepository = imageDatabaseRepository;

  @override
  ImageStoreState get initialState => ImageStoreInitial();

  @override
  Stream<ImageStoreState> mapEventToState(ImageStoreEvent event) async* {
    if (event is GetImage && event.url != null) {
      yield ImageStoreLoading();

      try {
        final imageFile = await _imageDatabaseRepository.getImage(event.url);

        yield ImageStoreLoaded(image: imageFile);
      } catch (err) {
        yield ImageStoreInitial();
      }
    }
  }
}
