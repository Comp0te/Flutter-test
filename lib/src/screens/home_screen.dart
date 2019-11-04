import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/helpers/helpers.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class HomeScreen extends StatefulWidget with OrientationMixin {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double gridViewCrossAxisSpacing = 5;
  final double gridViewMainAxisSpacing = 5;
  final double gridViewPaddingHorizontal = 10;
  final double gridViewPaddingVertical = 20;
  final _gridViewKey = GlobalKey();

  ScrollController _scrollController;
  PostersFetchBloc _postersFetchBloc;

  double get scrollOffset =>
      _scrollController.hasClients && _scrollController.offset >= 0
          ? _scrollController.offset
          : 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _postersFetchBloc = BlocProvider.of<PostersFetchBloc>(context)
      ..add(PostersFetchFirstPageRequest());
  }

  void loadMorePosters() {
    final state = _postersFetchBloc.state;

    if (state.hasNextPage && !state.isLoadingNextPage) {
      _postersFetchBloc.add(
        PostersFetchNextPageRequest(page: state.data.meta.page + 1),
      );
    }
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
    final gridViewColumnCount = widget.isPortrait(context) ? 2 : 3;

    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5),
          child: PosterFetchBlocListener(
            child: BlocBuilder<AppStateBloc, AppState>(
              builder: (context, state) {
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
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 0, 255, 1)),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
        title: const Text('Home'),
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
              BlocProvider.of<AuthBloc>(context).add(
                LoggedOut(),
              );
            },
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: BlocBuilder<AppStateBloc, AppState>(
          builder: (context, appState) {
            final postersList = appState.posters.values.toList();

            return SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RefreshRequestBlocListener<PostersFetchBloc,
                        PostersFetchState>(
                      onRefresh: () {
                        BlocProvider.of<PostersFetchBloc>(context).add(
                          PostersFetchFirstPageRequest(),
                        );
                      },
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
                          return postersList[index].images == null ||
                              postersList[index].images.isEmpty
                              ? Image.asset(
                            'assets/placeholder.png',
                            fit: BoxFit.cover,
                          )
                              : CachedNetworkImage(
                            imageUrl: postersList[index].images[0]?.file,
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
                            placeholder: (context, url) =>
                            const Spinner(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                  ),
                  BlocBuilder<PostersFetchBloc, PostersFetchState>(
                    builder: (context, state) {
                      return state.isLoadingNextPage
                          ? const Spinner()
                          : Container();
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// TODO: Add onRefresh behaviour
