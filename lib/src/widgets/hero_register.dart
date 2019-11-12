import 'package:flutter/material.dart';

import 'package:flutter_app/src/constants/assets.dart';

class HeroRegister extends StatelessWidget {
  final double width;
  final VoidCallback onTap;

  const HeroRegister({
    Key key,
    this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: ImageAssets.register,
        child: Material(
          shadowColor: Colors.blue,
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              ImageAssets.register,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
