import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class DatabaseScreen extends StatelessWidget {
  String _getUrlFromPosters(List<PosterNormalized> posters, int index) {
    return posters[index].images != null && posters[index].images.isNotEmpty
        ? posters[index].images[0]?.file
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final AppStateBloc _appStateBloc = BlocProvider.of<AppStateBloc>(context);
    final ImageStoreRepository _imageStoreRepository =
        RepositoryProvider.of<ImageStoreRepository>(context);

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Database posters'),
        centerTitle: true,
      ),
      body: BlocBuilder(
        bloc: _appStateBloc,
        builder: (context, AppState state) {
          var posters = state.posters.values.toList();

          return state.posters.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, int index) {
                    ImageStoreBloc _imageStoreBloc = ImageStoreBloc(
                      imageStoreRepository: _imageStoreRepository,
                    );

                    return Column(
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          title: Text(
                            'id - ${posters[index].id} - ${posters[index].text}',
                          ),
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: ImageFromStore(
                              imageStoreBloc: _imageStoreBloc,
                              url: _getUrlFromPosters(posters, index),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.blue,
                        )
                      ],
                    );
                  },
                  itemCount: state.posters.length,
                )
              : Spinner();
        },
      ),
    );
  }
}
