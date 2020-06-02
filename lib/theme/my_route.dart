import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// !experiment
class MyPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(PageRoute<T> route, BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var begin = 0.0;
    var end = 1.0;
    var tween = Tween(begin: begin, end: end);

    return CupertinoPageRoute.buildPageTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      Align(
        child: SizeTransition(
          sizeFactor: animation,
          child: child,
        ),
      ),
    );
  }
}
