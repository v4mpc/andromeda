import 'package:flutter/material.dart';

class CustomTheme {
  static final ThemeData baseLight = ThemeData.light();
  static final ThemeData baseDark = ThemeData.dark();
  static const Color primaryColor = Color(0xff00695C);

  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      primaryColor: primaryColor,
      textTheme: baseLight.textTheme.copyWith(
        headline2: baseLight.textTheme.headline2!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        subtitle1: baseLight.textTheme.subtitle1!.copyWith(
          color: Colors.white,

        ),
        subtitle2: baseLight.textTheme.subtitle2!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          // fontStyle: FontStyle.italic,
        ),
        bodyText1: baseLight.textTheme.bodyText1!.copyWith(
          color: Colors.white,
          fontSize: 18,
        ),
        caption: baseLight.textTheme.caption!.copyWith(
            fontWeight: FontWeight.w500,
          color: Colors.white

        )
      )
    );
  }
}
