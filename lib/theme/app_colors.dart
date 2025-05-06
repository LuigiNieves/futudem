import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF2E2E2E);
  static const inputFill = Colors.black;
  static const inputText = Colors.white;
  static const labelText = Colors.white;
  static const button = Colors.green; // GreenAccent
  static const buttonText = Colors.black;
  static const highlightText = Color(0xFF7CF26A);
}


final ThemeData mytheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xFF7CF26A),
  scaffoldBackgroundColor: Colors.black,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.green,
    textTheme: ButtonTextTheme.primary,
  ),
  focusColor: Colors.green,
  splashColor: Colors.green,
  highlightColor: Colors.green,

  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF3A3A3A),
    labelStyle: TextStyle(color: Colors.white),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF7CF26A), width: 2),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: Colors.green,
  ),

  tabBarTheme: const TabBarTheme(
    labelColor: Colors.green,
    unselectedLabelColor: Colors.white,
    indicatorColor: Colors.green,
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
    labelStyle: TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      shadowColor: Color(0xFF7CF26A),
      elevation: 4,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),

  cardTheme: const CardTheme(
    color: Color(0xFF2E2E2E),
    elevation: 6,
    margin: EdgeInsets.all(8),
  ),
);
