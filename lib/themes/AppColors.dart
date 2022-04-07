import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData defaultTheme = _buildMyTheme();
  static const PrimaryColor = const Color(0xFFb71c1c);
  static const PrimaryColorLight = const Color(0xFFf05545);
  static const PrimaryColorDark = const Color(0xFF7f0000);

  static const SecondaryColor = const Color(0xFFb2dfdb);
  static const SecondaryColorLight = const Color(0xFFe5ffff);
  static const SecondaryColorDark = const Color(0xFF82ada9);

  static const Background = const Color(0xFFfffdf7);
  static const TextColor = const Color(0xFFffffff);
  static const deco = const Color(0xff642908);
  static const more_bg = const Color(0xfff5e3cd);
  static const divider = const Color(0xffc0764d);
  static const search_bg = const Color(0xffe2c8a8);
  static const trans= const Color(0x80000000);
  static const AppBarThemes= const Color(0xFF642908);
  static const appbar_title=const Color(0xFFF3CC9E);


  static const AppBarTheme = const MaterialColor(0xff642908,  <int, Color>{
    50: Color(0xFF162A49),
    100: Color(0xFF162A49),
    200: Color(0xFF162A49),
    300: Color(0xFF162A49),
    400: Color(0xFF162A49),
    500: Color(0xFF162A49),
    600: Color(0xFF162A49),
    700: Color(0xFF162A49),
    800: Color(0xFF162A49),
    900: Color(0xFF162A49),
  },);
  static const Search_bg = const Color(0xF5F6F6F6);
  static ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: PrimaryColor,
      primaryColorDark: PrimaryColorDark,
      primaryColorLight: PrimaryColorLight,
      primaryColorBrightness: Brightness.dark,

      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: SecondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),

      scaffoldBackgroundColor: Background,
      cardColor: Background,
      textSelectionColor: PrimaryColorLight,
      backgroundColor: Background,
      textTheme: base.textTheme.copyWith(
          subtitle1: base.textTheme.headline6?.copyWith(color: TextColor),
          bodyText1: base.textTheme.bodyText2?.copyWith(color: TextColor),
          bodyText2: base.textTheme.bodyText1?.copyWith(color: TextColor)
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: SecondaryColor),
    );
  }
}