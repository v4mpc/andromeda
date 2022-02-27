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
      cardColor:const Color(0xffbd5ec4) ,
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
      // primaryColor: Colors.green,
      colorScheme: base.colorScheme.copyWith(
        primary: kShrinePink100,
        onPrimary: kShrineBrown900,
        secondary: kShrineBrown900,
        error: kShrineErrorRed,
      ),
      // TODO: Add the text themes (103)
      // TODO: Add the icon themes (103)
      // TODO: Decorate the inputs (103)
    );
  }


}






