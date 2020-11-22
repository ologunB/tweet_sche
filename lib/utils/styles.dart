import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Styles {
  static Color appPrimaryColor = Color(0xFF3F42CA);
  static Color appBackground = Color(0xFFF1E7FC);
  static Color appCanvasColor = Color(0xFF565DFF);
  static Color whiteColor = Colors.white;
  static Color appLightPrimaryColor = Color(0xa19EB7FF);

  static Color tintColor1 = Color(0xa1d0d0f5);
  static Color tintColor2 = Color(0xa1CDEDFF);
  static Color tintColor3 = Color(0xa1CCF6F3);
  static Color tintColor4 = Color(0xa1FDE2DE);
  static Color tintColor5 = Color(0xa15050eb);
  static Color tintColor6 = Color(0xa155b9f2);
  static Color tintColor7 = Color(0xa157ebe1);
  static Color tintColor8 = Color(0xa1f23d30);

  static InputDecoration input = InputDecoration(
    fillColor: Colors.white,
    focusColor: Colors.grey[900],
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
    border: OutlineInputBorder(
      gapPadding: 1.0,
      borderSide: BorderSide(color: Colors.grey[600], width: 1.0),
    ),
    hintStyle: TextStyle(
      color: Colors.grey[600],
    ),
  );
}

Widget mediumVerticalSpacer() => SizedBox(height: 10);

void moveToReplace(BuildContext context, whereTo) {
  Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => whereTo),
      (Route<dynamic> route) => false);
}

void moveTo(BuildContext context, whereTo) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => whereTo));
}
