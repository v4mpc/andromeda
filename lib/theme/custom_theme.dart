import 'package:flutter/material.dart';
import 'package:andromeda/colors.dart';

class CustomTheme {

  static ThemeData get lightTheme => _buildLightTheme();
  static ThemeData get darkTheme=>_buildDarkTheme();

  static ThemeData _buildDarkTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: kPrimary,
        onPrimary: kOnPrimary,
        secondary: kSecondary,
        onSecondary: Colors.white,
        error: kShrineErrorRed,
      ),
      // bottomAppBarColor: kBottomBar,
    );
  }
  static ThemeData _buildLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: kPrimary,
        onPrimary: kOnPrimary,
        secondary: kSecondary,
        onSecondary: kOnSecondary,
        error: kError,
      ),
      bottomAppBarColor: kBottomBar,
      // textTheme: _buildShrineTextTheme(base.textTheme),
      // textSelectionTheme: const TextSelectionThemeData(
      //   selectionColor: kShrinePink100,
      // ),
      // inputDecorationTheme: const InputDecorationTheme(
      //   focusedBorder: CutCornersBorder(
      //     borderSide: BorderSide(
      //       width: 2.0,
      //       color: kShrineBrown900,
      //     ),
      //   ),
      //   border: CutCornersBorder(),
    );
  }
  //
  // static TextTheme _buildShrineTextTheme(TextTheme base) {
  //   return base
  //       .copyWith(
  //         headline5: base.headline5!.copyWith(
  //           fontWeight: FontWeight.w500,
  //         ),
  //         headline6: base.headline6!.copyWith(
  //           fontSize: 18.0,
  //         ),
  //         caption: base.caption!.copyWith(
  //           fontWeight: FontWeight.w400,
  //           fontSize: 14.0,
  //         ),
  //         bodyText1: base.bodyText1!.copyWith(
  //           fontWeight: FontWeight.w500,
  //           fontSize: 16.0,
  //         ),
  //       )
  //       .apply(
  //         displayColor: kShrineBrown900,
  //         bodyColor: kShrineBrown900,
  //       );
  // }
}
