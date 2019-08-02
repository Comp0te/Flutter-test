import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/utils/scroll_helper.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/blocks/blocks.dart';

class AlterHomeScreen extends StatefulWidget {
  @override
  _AlterHomeScreenState createState() => _AlterHomeScreenState();
}

class _AlterHomeScreenState extends State<AlterHomeScreen> {
  final int gridViewColumnCount = 2;
  final double gridViewCrossAxisSpacing = 5;
  final double gridViewMainAxisSpacing = 5;
  final double gridViewPaddingHorizontal = 10;
  final double gridViewPaddingVertical = 20;
  final GlobalKey _gridViewKey = GlobalKey();

  ScrollController _scrollController;
  PostersFetchBloc _postersFetchBloc;
  StreamSubscription<PostersFetchState> postersFetchStateSubscription;

  double get scrollOffset =>
      _scrollController.hasClients && _scrollController.offset >= 0
          ? _scrollController.offset
          : 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _postersFetchBloc = BlocProvider.of<PostersFetchBloc>(context)
      ..dispatch(PostersFetchFirstPageRequest());
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

      postersFetchStateSubscription.cancel();
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: BlocBuilder(
            bloc: _appStateBloc,
            builder: (BuildContext context, AppState state) {
              return AnimatedBuilder(
                animation: _scrollController,
                builder: (BuildContext context, Widget widget) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 5,
                        width: ScrollHelper.calcGridViewScrolledWidth(
                          context: context,
                          state: state,
                          gridViewKey: _gridViewKey,
                          scrollOffset: scrollOffset,
                          columnCount: gridViewColumnCount,
                          paddingHorizontal: gridViewPaddingHorizontal,
                          paddingVertical: gridViewPaddingVertical,
                          crossAxisSpacing: gridViewCrossAxisSpacing,
                          mainAxisSpacing: gridViewMainAxisSpacing,
                        ),
                        decoration:
                            BoxDecoration(color: Color.fromRGBO(0, 0, 255, 1)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        title: Text('Home'),
        centerTitle: true,
        actions: <Widget>[
          AnimatedBuilder(
            animation: _scrollController,
            builder: (BuildContext context, Widget widget) {
              return IconButton(
                icon: Transform.rotate(
                  angle: (math.pi * scrollOffset / 1000),
                  child: Icon(
                    Icons.settings,
                    size: 30,
                  ),
                ),
                onPressed: () {
                  _scrollController.jumpTo(0);
                },
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              size: 30,
            ),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).dispatch(
                LoggedOut(),
              );
            },
          ),
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
                    key: _gridViewKey,
                    padding: EdgeInsets.symmetric(
                      horizontal: gridViewPaddingHorizontal,
                      vertical: gridViewPaddingVertical,
                    ),
                    controller: _scrollController,
                    itemCount: postersList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridViewColumnCount,
                      crossAxisSpacing: gridViewCrossAxisSpacing,
                      mainAxisSpacing: gridViewMainAxisSpacing,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      ImageStoreBloc _imageStoreBloc = ImageStoreBloc(
                        imageStoreRepository: _imageStoreRepository,
                      );

                      return ImageFromStore(
                        imageStoreBloc: _imageStoreBloc,
                        url: _getUrlFromPosters(postersList, index),
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

// TODO: Add onRefresh behaviour
// TODO: synchronize the recording and reading of images from the Documents directory
// TODO: Find a solution of double call initState on ios
