import 'package:flutter/material.dart';

import 'package:flutter_app/src/routes/login_route.dart';
import 'package:flutter_app/src/routes/register_route.dart';
import 'package:flutter_app/src/utils/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder>{
        RouteNames.login: (BuildContext context) => LoginRoute(),
        RouteNames.register: (BuildContext context) => RegisterRoute()
      },
      initialRoute: RouteNames.login,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
