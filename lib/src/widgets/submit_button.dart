import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final bool isLoading;

  const SubmitButton({
    Key key,
    this.onPress,
    @required this.title,
    @required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: isLoading
          ? Container(
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : Container(
              width: 120,
              child: RaisedButton(
                textColor: Colors.white,
                onPressed: onPress,
                elevation: 5,
                color: Theme.of(context).accentColor,
                child: Text(title),
              ),
            ),
    );
  }
}
