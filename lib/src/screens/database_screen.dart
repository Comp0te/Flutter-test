import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class DatabaseScreen extends StatelessWidget with OrientationMixin {
  @override
  Widget build(BuildContext context) {
    final _imageStoreRepository =
        RepositoryProvider.of<ImageStoreRepository>(context);
    final showImageCount = isPortrait(context) ? 3 : 5;

    Future<List<Widget>> _getImagesFromStore(
      PosterNormalized poster,
      int showImageCount,
    ) {
      if (poster.images != null && poster.images.isNotEmpty) {
        return Stream.fromIterable(poster.images)
            .take(showImageCount)
            .map((image) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: ImageFromStore(
                      imageStoreBloc: ImageStoreBloc(
                        imageStoreRepository: _imageStoreRepository,
                      ),
                      url: image.file,
                    ),
                  ),
                ))
            .toList();
      }

      return Future.value([
        Image.asset(
          'assets/placeholder.png',
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        )
      ]);
    }

    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Database posters'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<AppStateBloc, AppState>(
          builder: (context, state) {
            final posters = state.posters.values.toList();

            return state.posters.isEmpty
                ? const Spinner()
                : ListView.separated(
                    itemBuilder: (context, int index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            title: Text(
                              'id - ${posters[index].id} - ${posters[index].text}',
                            ),
                            subtitle: Text('price - ${posters[index].price}'),
                          ),
                        ),
                        FutureBuilder<List<Widget>>(
                          future: _getImagesFromStore(
                            posters[index],
                            showImageCount,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Row(
                                  children: snapshot.data,
                                  mainAxisSize: MainAxisSize.min,
                                ),
                              );
                            }

                            return const Spinner();
                          },
                        ),
                      ],
                    ),
                    itemCount: state.posters.length,
                    separatorBuilder: (context, int index) => Divider(
                      height: 2,
                      color: index % 2 == 0 ? Colors.red : Colors.blue,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
