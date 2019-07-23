import 'package:flutter/material.dart';

class HeroRegister extends StatelessWidget {
  final String photo = 'assets/register.jpg';
  final double width;
  final VoidCallback onTap;

  const HeroRegister({
    Key key,
    this.onTap,
    this.width,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          shadowColor: Colors.blue,
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
