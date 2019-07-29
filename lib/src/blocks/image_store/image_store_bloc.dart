import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class ImageStoreBloc extends Bloc<ImageStoreEvent, ImageStoreState> {
  final ImageStoreRepository _imageStoreRepository;

  ImageStoreBloc({
    @required ImageStoreRepository imageStoreRepository,
  })  : assert(imageStoreRepository != null),
        _imageStoreRepository = imageStoreRepository;

  ImageStoreState get initialState => ImageStoreState.init();

  @override
  Stream<ImageStoreState> mapEventToState(ImageStoreEvent event) async* {
    if (event is SaveImageToStore) {
      yield ImageStoreState.loading();

      try {
        final imageFile = await _imageStoreRepository.saveImage(event.url);

        yield ImageStoreState.loaded(imageFile);
      } catch (err) {
        print('image save error: $err');

        yield ImageStoreState.init();
      }
    } else if (event is ReadImageFromStore) {
      yield ImageStoreState.loading();

      try {
        final imageFile = await _imageStoreRepository.getImage(event.url);

        yield ImageStoreState.loaded(imageFile);
      } catch (err) {
        print('image read error: $err');

        yield ImageStoreState.init();
      }
    }
  }
}
