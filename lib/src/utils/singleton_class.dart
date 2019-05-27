import 'package:flutter/material.dart';

class MySingleton {
  static final MySingleton _instance = MySingleton._internal();
  MySingleton instance = _instance;

  factory MySingleton() => _instance;

  MySingleton._internal() {
    // init things inside this
    // for parameterized singleton
    if (_instance == null) {
      instance = MySingleton();
    } else {
      instance = _instance;
    }
  }

  static Widget putMargin(
      {double all, double top, double bottom, double start, double end}) {
    if (top.toString() != 'null') {
      return Container(
        margin: EdgeInsets.only(top: top),
      );
    } else if (start.toString() != 'null') {
      return Container(
        margin: EdgeInsets.only(left: start),
      );
    } else if (bottom.toString() != 'null') {
      return Container(
        margin: EdgeInsets.only(bottom: bottom),
      );
    } else if (end.toString() != 'null') {
      return Container(
        margin: EdgeInsets.only(right: end),
      );
    } else if (all.toString() != 'null') {
      return Container(
        margin: EdgeInsets.all(all),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(20.0),
      );
    }
    /*return Container(
      margin: EdgeInsets.all(all),
    );*/
  }
}
