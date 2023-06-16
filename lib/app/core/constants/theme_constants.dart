import 'package:flutter/material.dart';

import 'colors_constants.dart';

class ThemeConstants {
  static ThemeData light = ThemeData(
    fontFamily: "NunitoSans",
    primaryColor: ColorsConstants.primary,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ColorsConstants.primary,
      onPrimary: Colors.white,
      secondary: ColorsConstants.primary,
      onSecondary: Colors.white,
      background: ColorsConstants.background,
      onBackground: ColorsConstants.text,
      error: ColorsConstants.error,
      onError: Colors.white,
      surface: ColorsConstants.card,
      onSurface: ColorsConstants.text,
    ),
    scaffoldBackgroundColor: ColorsConstants.background,
    cardColor: ColorsConstants.card,
    cardTheme: const CardTheme(
      color: ColorsConstants.card,
    ),
    appBarTheme: const AppBarTheme(
      color: ColorsConstants.appBarBackground,
      iconTheme: IconThemeData(color: ColorsConstants.appBarIcon),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: ColorsConstants.appBarText,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        fontFamily: "NunitoSans",
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: ColorsConstants.tabBarSelectedText,
      unselectedLabelColor: ColorsConstants.tabBarUnselectedText,
      unselectedLabelStyle: TextStyle(
        color: ColorsConstants.tabBarUnselectedText,
        fontFamily: "NunitoSans",
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      labelStyle: TextStyle(
        color: ColorsConstants.primary,
        fontFamily: "NunitoSans",
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: ColorsConstants.text,
        fontWeight: FontWeight.bold,
        fontSize: 30,
        fontFamily: "NunitoSans",
      ),
      displayMedium: TextStyle(
        color: ColorsConstants.text,
        fontWeight: FontWeight.bold,
        fontSize: 26,
        fontFamily: "NunitoSans",
      ),
      displaySmall: TextStyle(
        color: ColorsConstants.text,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: "NunitoSans",
      ),
      titleLarge: TextStyle(
        color: ColorsConstants.text,
        fontWeight: FontWeight.w800,
        fontSize: 24,
        fontFamily: "NunitoSans",
      ),
      titleMedium: TextStyle(
        color: ColorsConstants.text,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        fontFamily: "NunitoSans",
      ),
      titleSmall: TextStyle(
        color: ColorsConstants.textExtraLight,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        fontFamily: "NunitoSans",
      ),
      bodyLarge: TextStyle(
        color: ColorsConstants.text,
        fontWeight: FontWeight.normal,
        fontSize: 16,
        fontFamily: "NunitoSans",
      ),
      bodyMedium: TextStyle(
        color: ColorsConstants.text,
        fontWeight: FontWeight.normal,
        fontSize: 14,
        fontFamily: "NunitoSans",
      ),
      bodySmall: TextStyle(
        color: ColorsConstants.textExtraLight,
        fontWeight: FontWeight.normal,
        fontSize: 14,
        fontFamily: "NunitoSans",
      ),
    ),
  );
}
