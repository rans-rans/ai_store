import 'package:flutter/material.dart';

import 'numbers.dart';

const primaryColor = Color.fromARGB(255, 255, 177, 60);
const secondaryColor = Color.fromRGBO(231, 226, 214, 1);

final lightTheme = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(inputBorderRadius),
      borderSide: const BorderSide(color: primaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(inputBorderRadius),
      borderSide: const BorderSide(color: primaryColor),
    ),
  ),
  colorScheme: const ColorScheme.light(secondary: secondaryColor),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.white,
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.black)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    surfaceTintColor: Colors.white,
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.white,
  ),
);
final darkTheme = ThemeData.dark().copyWith(
  primaryColor: primaryColor,
  popupMenuTheme: const PopupMenuThemeData(
    surfaceTintColor: Colors.black,
  ),
  colorScheme: const ColorScheme.dark(secondary: secondaryColor),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(inputBorderRadius),
      borderSide: const BorderSide(color: primaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(inputBorderRadius),
      borderSide: const BorderSide(color: primaryColor),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.white)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
  ),
);
