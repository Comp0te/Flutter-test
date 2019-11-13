import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class DatabaseScreen extends StatefulWidget with OrientationMixin, ThemeMixin {
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DBBloc>(context).add(DBGetNormalizedPosters());
  }

  @override
  Widget build(BuildContext context) {
    final showImageCount = widget.isPortrait(context) ? 3 : 5;

    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: Text(
          S.of(context).postersDB,
          style: widget.getPrimaryTextTheme(context).headline,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<AppStateBloc, AppState>(
          builder: (context, state) {
            final posters = state.posters.values.toList();

            if (state.posters.isEmpty) return const Spinner();

            return ListView.separated(
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
                        style: widget.getTextTheme(context).title,
                      ),
                      subtitle: Text(
                        S.of(context).getPrice('${posters[index].price}'),
                        style: widget.getTextTheme(context).body1,
                      ),
                    ),
                  ),
                  FutureBuilder<List<Widget>>(
                    future: _getImagesFromStore(
                      context: context,
                      poster: posters[index],
                      showImageCount: showImageCount,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
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
                color: widget.getTheme(context).dividerColor,
                thickness: 2,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<List<Widget>> _getImagesFromStore({
    BuildContext context,
    PosterNormalized poster,
    int showImageCount,
  }) {
    final _imageStoreRepository =
        RepositoryProvider.of<ImageStoreRepository>(context);

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
      const PosterPlaceholderImage(
        width: 50,
        height: 50,
      )
    ]);
  }
}
