import 'package:flutter/material.dart'
    show
        AppBarTheme,
        CardTheme,
        Color,
        Colors,
        ElevatedButton,
        ElevatedButtonThemeData,
        TextButton,
        TextButtonThemeData,
        ThemeData;

const primaryColor = Color.fromARGB(255, 255, 177, 60);
const primaryColorLight = Color.fromARGB(107, 255, 177, 60);

final lightTheme = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.white,
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.black)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.white,
    // color: Colors.white,
  ),
);
final darkTheme = ThemeData.dark().copyWith(
  primaryColor: primaryColor,
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.black,
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.white)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
  ),
);
