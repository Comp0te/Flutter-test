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
    final screenSize = MediaQuery.of(context).size;
    final gridViewBox =
        gridViewKey.currentContext.findRenderObject() as RenderBox;

    final gridViewContentHeight =
        gridViewBox.hasSize ? gridViewBox.size.height - 2 * paddingVertical : 0;

    final itemsTotalWidth = screenSize.width -
        2 * paddingHorizontal +
        crossAxisSpacing * (columnCount - 1);

    final itemHeight = itemsTotalWidth / columnCount;

    final visibleItems = (gridViewContentHeight * columnCount) /
        (itemHeight + mainAxisSpacing * (columnCount - 1));

    final invisibleItems =
        state.posters.isNotEmpty ? state.posters.length - visibleItems : 0;

    final fillRate = invisibleItems != 0
        ? columnCount * scrollOffset / itemHeight / invisibleItems
        : 0;

    return fillRate > 1 ? screenSize.width : screenSize.width * fillRate;
  }
}
