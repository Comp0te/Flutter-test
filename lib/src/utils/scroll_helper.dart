import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocks/blocks.dart';

// TODO: rework for greater versatility and readability
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
    final RenderBox gridViewBox = gridViewKey.currentContext.findRenderObject();
    final double gridViewHeight =
        gridViewBox.hasSize ? gridViewBox.size.height - 2 * paddingVertical : 0;

    final double itemHeight = (screenSize.width -
            2 * paddingHorizontal +
            crossAxisSpacing * (columnCount - 1)) /
        columnCount;

    final double totalItemsCount = state.posters.isNotEmpty
        ? state.posters.length -
            gridViewHeight *
                columnCount /
                (itemHeight + mainAxisSpacing * (columnCount - 1))
        : 0;

    final double fillRate = totalItemsCount != 0
        ? (columnCount * scrollOffset / itemHeight) / totalItemsCount
        : 0;

    return fillRate > 1 ? screenSize.width : screenSize.width * fillRate;
  }
}
