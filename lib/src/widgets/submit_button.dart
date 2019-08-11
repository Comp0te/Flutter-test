import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final bool isLoading;
  final Color color;

  const SubmitButton({
    Key key,
    this.onPress,
    @required this.title,
    @required this.isLoading,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: isLoading
          ? Container(
              width: 30,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          : Container(
              width: 120,
              child: RaisedButton(
                textColor: Colors.white,
                onPressed: onPress,
                elevation: 5,
                color: color,
                child: Text(title),
              ),
            ),
    );
  }
}
