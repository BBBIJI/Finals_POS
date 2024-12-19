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

  // Push and replace the current route with a new route
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

  // Push and remove all previous routes
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

  // Pop the current route
  static void pop(BuildContext context, {dynamic result}) {
    Navigator.pop(context, result);
  }

  // Push with a fade transition
  static void pushWithFade(BuildContext context, Widget widget,
      {Object? arguments,
      Duration duration = const Duration(milliseconds: 300)}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: duration,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }
}
