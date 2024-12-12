import 'package:flutter/material.dart';

class AppNavigator {
  // Push a new route onto the stack
  static void push(BuildContext context, Widget widget, {Object? arguments}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  // push replacement of current route with new route
  static void pushReplacement(BuildContext context, Widget widget,
      {Object? arguments}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  // push and remove all previous routes
  static void pushAndRemoveAll(BuildContext context, Widget widget,
      {Object? arguments}) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(arguments: arguments),
      ),
      (route) => false,
    );
  }

  // pop navigator
  static void pop(BuildContext context, {dynamic result}) {
    Navigator.pop(context, result);
  }
}
