import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

abstract class ScrollHelper {
  static double calcGridViewScrolledWidth({
    @required BuildContext context,
    @required AppState state,
    @required GlobalKey gridViewKey,
    @required double scrollOffset,
    @required int columnCount,
    double paddingHorizontal = 0,
    double paddingVertical = 0,
    double crossAxisSpacing = 0,
    double mainAxisSpacing = 0,
  }) {
    final Size screenSize = MediaQuery.of(context).size;
    final RenderBox gridViewBox =
        gridViewKey.currentContext.findRenderObject() as RenderBox;

    final double gridViewContentHeight =
        gridViewBox.hasSize ? gridViewBox.size.height - 2 * paddingVertical : 0;

    final double itemsTotalWidth = screenSize.width -
        2 * paddingHorizontal +
        crossAxisSpacing * (columnCount - 1);

    final double itemHeight = itemsTotalWidth / columnCount;

    final double visibleItems = (gridViewContentHeight * columnCount) /
        (itemHeight + mainAxisSpacing * (columnCount - 1));

    final double invisibleItems =
        state.posters.isNotEmpty ? state.posters.length - visibleItems : 0;

    final double fillRate = invisibleItems != 0
        ? columnCount * scrollOffset / itemHeight / invisibleItems
        : 0;

    return fillRate > 1 ? screenSize.width : screenSize.width * fillRate;
  }
}
