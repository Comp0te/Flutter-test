import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin SnackBarMixin on StatelessWidget {
  ScaffoldState showSnackBarError({
    @required BuildContext context,
    @required Exception error,
  }) {
    String getErrorMessage(Exception error) {
      if (error is DioError) {
        return error.response?.statusMessage ?? error.message;
      } else if (error is PlatformException) {
        return error.message;
      }

      return 'Something went wrong';
    }

    return Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text('${getErrorMessage(error)}'),
              ),
              Icon(Icons.error),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
  }
}
