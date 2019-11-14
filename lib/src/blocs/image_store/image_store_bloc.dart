import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class ImageStoreBloc extends Bloc<ImageStoreEvent, ImageStoreState> {
  final ImageStoreRepository _imageStoreRepository;

  ImageStoreBloc({
    @required ImageStoreRepository imageStoreRepository,
  })  : assert(imageStoreRepository != null),
        _imageStoreRepository = imageStoreRepository;

  @override
  ImageStoreState get initialState => ImageStoreInitial();

  @override
  Stream<ImageStoreState> mapEventToState(ImageStoreEvent event) async* {
    if (event is GetImage && event.url != null) {
      yield ImageStoreLoading();

      try {
        final imageFile = await _imageStoreRepository.getImage(event.url);

        yield ImageStoreLoaded(image: imageFile);
      } catch (err) {
        yield ImageStoreInitial();
      }
    }
  }
}
