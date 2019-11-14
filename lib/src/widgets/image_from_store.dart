import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class ImageFromStore extends StatefulWidget {
  final ImageStoreBloc _imageStoreBloc;
  final String _url;

  const ImageFromStore({
    Key key,
    @required ImageStoreBloc imageStoreBloc,
    @required String url,
  })  : assert(imageStoreBloc != null),
        _imageStoreBloc = imageStoreBloc,
        _url = url,
        super(key: key);

  @override
  _ImageFromStoreState createState() => _ImageFromStoreState();
}

class _ImageFromStoreState extends State<ImageFromStore> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget._imageStoreBloc..add(GetImage(url: widget._url));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageStoreBloc, ImageStoreState>(
      bloc: widget._imageStoreBloc,
      builder: (context, state) {
        if (state is ImageStoreLoading) {
          return const Spinner();
        }

        if (state is ImageStoreLoaded) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(state.image),
                fit: BoxFit.cover,
              ),
            ),
          );
        }

        return const PosterPlaceholderImage();
      },
    );
  }
}
