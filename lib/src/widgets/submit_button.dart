import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final bool isLoading;
  final Color color;
  final EdgeInsets margin;

  const SubmitButton({
    Key key,
    this.onPress,
    @required this.title,
    @required this.isLoading,
    this.color = Colors.blue,
    this.margin = const EdgeInsets.only(bottom: 25),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: RaisedButton(
        textColor: Colors.white,
        onPressed: onPress,
        elevation: 5,
        color: color,
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 200,
            minHeight: 45,
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          child: isLoading
              ? Container(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    backgroundColor: Colors.white,
                  ),
                )
              : Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
