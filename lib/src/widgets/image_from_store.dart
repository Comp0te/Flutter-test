import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class ImageFromStore extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocBuilder<ImageStoreBloc, ImageStoreState>(
      bloc: _imageStoreBloc..add(GetImage(url: _url)),
      builder: (context, state) {
        if (state.isLoading) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(
              width: 1,
              color: Colors.blue,
            )),
            child: Spinner(),
          );
        } else if (state.image == null) {
          return Image.asset(
            'assets/placeholder.png',
            fit: BoxFit.cover,
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(state.image),
                fit: BoxFit.cover,
              ),
            ),
          );
        }
      },
    );
  }
}
