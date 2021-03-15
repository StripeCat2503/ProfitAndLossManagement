import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteHelper {
  static void route(BuildContext context, Widget screen) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
  }
}
