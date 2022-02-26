import 'package:flutter/material.dart';

class CustomTheme {
  static final ThemeData baseLight = ThemeData.light();
  static final ThemeData baseDark = ThemeData.dark();
  static const Color primaryColor = Color(0xff00695C);

  // static ThemeData get lightTheme {
  //   return ThemeData.light().copyWith(
  //       inputDecorationTheme:baseLight.inputDecorationTheme.copyWith(
  //         focusColor: primaryColor,
  //
  //       ),
  //     primaryColor: primaryColor,
  //
  //     textTheme: baseLight.textTheme.copyWith(
  //       headline2: baseLight.textTheme.headline2!.copyWith(
  //         fontWeight: FontWeight.bold,
  //         color: Colors.white,
  //       ),
  //
  //       subtitle2: baseLight.textTheme.subtitle2!.copyWith(
  //         fontWeight: FontWeight.bold,
  //         color: Colors.white,
  //         // fontStyle: FontStyle.italic,
  //       ),
  //         button: baseLight.textTheme.button!.copyWith(
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white,
  //           // fontStyle: FontStyle.italic,
  //         ),
  //       bodyText1: baseLight.textTheme.bodyText1!.copyWith(
  //         color: Colors.white,
  //         fontSize: 18,
  //       ),
  //       caption: baseLight.textTheme.caption!.copyWith(
  //           fontWeight: FontWeight.w500,
  //         color: Colors.white
  //
  //       )
  //     )
  //   );
  // }

  static ThemeData get darkTheme {
    return ThemeData(

      brightness: Brightness.dark,
      primaryColor: const Color(0xff00695C),
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
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(Color(0xffab02ee)),
        checkColor: MaterialStateProperty.all(Colors.white),
      ),
      brightness: Brightness.light,
      primaryColor: const Color(0xff00695C),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.orange,
      ).copyWith(
        primary: const Color(0xff00695C),
        onPrimary: Colors.white,

      ),
    );
  }
}
