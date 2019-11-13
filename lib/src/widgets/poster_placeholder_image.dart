import 'package:flutter/material.dart';

import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/mixins/mixins.dart';

class PosterPlaceholderImage extends StatelessWidget with ThemeMixin {
  final double width;
  final double height;

  const PosterPlaceholderImage({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _invertOnDarkMode(
      context: context,
      image: Image.asset(
        ImageAssets.posterPlaceholder,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }

  Widget _invertOnDarkMode({
    @required BuildContext context,
    @required Image image,
  }) {
    return getTheme(context).brightness == Brightness.dark
        ? ColorFiltered(
            colorFilter: ColorFilter.matrix(invertFilterMatrix),
            child: image,
          )
        : image;
  }
}
