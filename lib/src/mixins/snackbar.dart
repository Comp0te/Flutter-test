import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

mixin SnackBarMixin on StatelessWidget {
  ScaffoldState showSnackBarError({
    @required BuildContext context,
    @required Exception error,
  }) {
    return Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Error: ${(error as DioError).message}'),
              Icon(Icons.error),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
  }
}
