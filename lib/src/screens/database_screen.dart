import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class DatabaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppStateBloc _appStateBloc = BlocProvider.of<AppStateBloc>(context);
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
                            child: CachedNetworkImage(
                              imageUrl: posters[index].images == null ||
                                      posters[index].images.isEmpty
                                  ? 'http://via.placeholder.com/'
                                      '200x200.png?text=PlaceHolder'
                                  : posters[index].images[0]?.file,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              placeholder: (context, url) => Spinner(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
