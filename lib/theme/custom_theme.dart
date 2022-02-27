import 'package:flutter/material.dart';
import 'package:andromeda/colors.dart';

class CustomTheme {
  static final ThemeData baseLight = ThemeData.light();
  static final ThemeData baseDark = ThemeData.dark();
  static const Color primaryColor = Color(0xff65c45e);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
      ).copyWith(
        primary: const Color(0xff00695C),
        onPrimary: Colors.white,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      bottomAppBarColor: Colors.green[100],
      cardColor: const Color(0xffbd5ec4),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(
          const Color(0xffab02ee),
        ),
        checkColor: MaterialStateProperty.all(Colors.white),
      ),
      brightness: Brightness.light,
      primaryColor: primaryColor,
    );
  }

  static ThemeData get kShrineTheme => _buildShrineTheme();

  static ThemeData _buildShrineTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: kShrinePink100,
        onPrimary: kShrineBrown900,
        secondary: kShrineBrown900,
        error: kShrineErrorRed,
      ),
      textTheme: _buildShrineTextTheme(base.textTheme),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: kShrinePink100,
      ),
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

  static TextTheme _buildShrineTextTheme(TextTheme base) {
    return base
        .copyWith(
          headline5: base.headline5!.copyWith(
            fontWeight: FontWeight.w500,
          ),
          headline6: base.headline6!.copyWith(
            fontSize: 18.0,
          ),
          caption: base.caption!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          bodyText1: base.bodyText1!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        )
        .apply(
          displayColor: kShrineBrown900,
          bodyColor: kShrineBrown900,
        );
  }
}
