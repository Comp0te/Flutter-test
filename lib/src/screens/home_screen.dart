import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/blocks/blocks.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;
  PostersFetchBloc _postersFetchBloc;
  StreamSubscription<PostersFetchState> postersFetchStateSubscription;

  double get offset => _scrollController.hasClients ? _scrollController.offset : 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _postersFetchBloc = BlocProvider.of<PostersFetchBloc>(context);
  }

  @override
  void dispose() {
    postersFetchStateSubscription?.cancel();
    super.dispose();
  }

  void loadMorePosters() {
    postersFetchStateSubscription =
        _postersFetchBloc.state.take(1).listen((state) {
      if (state.hasNextPage && !state.isLoadingNextPage) {
        _postersFetchBloc.dispatch(
          PostersFetchNextPageRequest(page: state.data.meta.page + 1),
        );
      }
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollController.position.extentAfter <= 300) {
        loadMorePosters();
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final AppStateBloc _appStateBloc = BlocProvider.of<AppStateBloc>(context);

    return Scaffold(
      appBar: AppBar(
        leading: AnimatedBuilder(
          animation: _scrollController,
          builder: (BuildContext context, Widget widget) {
            return Transform.rotate(
              angle: (math.pi * offset / 1000),
              child: Icon(
                Icons.settings,
                size: 40,
              ),
            );
          },
        ),
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).dispatch(
                LoggedOut(),
              );
            },
          )
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: BlocBuilder(
          bloc: _appStateBloc,
          builder: (BuildContext context, AppState appState) {
            List<PosterNormalized> postersList =
                appState.posters.values.toList();

            return Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    controller: _scrollController,
                    itemCount: postersList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return CachedNetworkImage(
                        imageUrl: postersList[index].images.isEmpty
                            ? 'http://via.placeholder.com/'
                                '200x200.png?text=PlaceHolder'
                            : postersList[index].images[0]?.file,
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      );
                    },
                  ),
                ),
                BlocBuilder(
                  bloc: _postersFetchBloc,
                  builder: (BuildContext context, PostersFetchState state) {
                    return state.isLoadingNextPage ? Spinner() : Container();
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
