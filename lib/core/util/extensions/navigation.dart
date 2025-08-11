import 'dart:io';
import 'package:rakaan/core/framework/navigation_animation.dart';
import 'package:flutter/material.dart';

extension NavigationHelper on BuildContext {
  push(Widget page) {
    return Navigator.of(this).push(
      Platform.isAndroid
          ? FadePageRoute(builder: (context) => page)
          : MaterialPageRoute(builder: (context) => page),
    );
  }

  pushWithNamed(String pageRoute, {Object? arguments}) {
    return Navigator.of(this).pushNamed(
      pageRoute,
      arguments: arguments,
    );
  }

  pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(
      Platform.isAndroid
          ? FadePageRoute(builder: (context) => page)
          : MaterialPageRoute(builder: (context) => page),
    );
  }

  pushReplacementWithNamed(String pageRoute, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(
      pageRoute,
      arguments: arguments,
    );
  }

  pushAndRemoveUntil(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      Platform.isAndroid
          ? FadePageRoute(builder: (context) => page)
          : MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  pushAndRemoveUntilWithNamed(String pageRoute, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      pageRoute,
      (route) => false,
      arguments: arguments,
    );
  }

  pop() {
    Navigator.of(this).pop();
  }
}
