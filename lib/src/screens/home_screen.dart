import 'dart:async';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/helpers/helpers.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

class HomeScreen extends StatefulWidget with OrientationMixin, ThemeMixin {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double gridViewCrossAxisSpacing = 5;
  final double gridViewMainAxisSpacing = 5;
  final double gridViewPaddingHorizontal = 10;
  final double gridViewPaddingVertical = 20;
  final _gridViewKey = GlobalKey();
  final _loadMorePostersSubject = PublishSubject<PostersFetchNextPageRequest>();
  StreamSubscription loadMorePostersSubscription;

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

    loadMorePostersSubscription = _loadMorePostersSubject.stream
        .debounceTime(const Duration(milliseconds: 100))
        .listen((event) => _postersFetchBloc.add(event));
  }

  @override
  void dispose() {
    loadMorePostersSubscription?.cancel();
    super.dispose();
  }

  void loadMorePosters() {
    final state = _postersFetchBloc.state;

    if (state is PostersFetchSuccessful && state.hasNextPage) {
      _loadMorePostersSubject.sink
          .add(PostersFetchNextPageRequest(page: state.data.meta.page + 1));
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollController.position.extentAfter <= 500) {
        loadMorePosters();
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final gridViewColumnCount = widget.isPortrait(context) ? 2 : 3;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Scaffold(
          drawer: const MainDrawer(),
          appBar: _buildAppBar(context, gridViewColumnCount),
          body: NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: BlocBuilder<AppStateBloc, AppState>(
              builder: (context, appState) {
                final postersList = appState.posters.values.toList();

                if (postersList.isEmpty) return const Spinner();

                return RefreshRequestBlocListener<PostersFetchBloc,
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
                      final imageUrl = postersList[index]?.images == null ||
                              postersList[index].images.isEmpty
                          ? null
                          : postersList[index].images[0]?.file;

                      if (index == postersList.length) {
                        return Column(
                          children: <Widget>[
                            _buildPosterImage(imageUrl: imageUrl),
                          ],
                        );
                      }

                      return _buildPosterImage(imageUrl: imageUrl);
                    },
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: MediaQuery.of(context).size.width / 2 - 25,
          child: BlocBuilder<PostersFetchBloc, PostersFetchState>(
            builder: (context, state) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: state is PostersFetchNextRequestLoading
                    ? const Spinner()
                    : Container(),
              );
            },
          ),
        )
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    int gridViewColumnCount,
  ) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(5),
        child: PosterFetchBlocListener(
          child: BlocBuilder<AppStateBloc, AppState>(
            builder: (context, state) {
              return AnimatedBuilder(
                animation: _scrollController,
                builder: (BuildContext context, Widget animatedWidget) {
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
                        decoration: BoxDecoration(
                          color: widget.getTheme(context).accentColor,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
      title: Text(
        S.of(context).posters,
        style: widget.getPrimaryTextTheme(context).headline,
      ),
      centerTitle: true,
      actions: <Widget>[
        AnimatedBuilder(
          animation: _scrollController,
          builder: (BuildContext context, Widget animatedWidget) {
            return IconButton(
              icon: Transform.rotate(
                angle: (math.pi * scrollOffset / 1000),
                child: Icon(
                  Icons.settings,
                  size: 30,
                  color: widget.getTheme(context).primaryIconTheme.color,
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
            color: widget.getTheme(context).primaryIconTheme.color,
          ),
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(
              LoggedOut(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPosterImage({String imageUrl}) {
    return imageUrl != null
        ? CachedNetworkImage(
            imageUrl: imageUrl,
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
            placeholder: (context, url) => const Spinner(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        : const PosterPlaceholderImage();
  }
}
