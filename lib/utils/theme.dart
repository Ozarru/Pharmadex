import 'package:flutter/material.dart';

ThemeData customTheme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.grey[200],
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 0, 17, 116),
        onPrimary: Color(0xffffffff),
        secondary: Colors.blue,
        onSecondary: Color(0xffffffff),
        tertiary: Colors.deepOrange,
        error: Color(0xffffffff),
        onError: Color(0xffffffff),
        background: Colors.grey,
        onBackground: Color(0xffffffff),
        surface: Color(0xffffffff),
        onSurface: Color(0xffffffff),
      ),
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        headline2: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        headline3: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        headline4: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        headline5: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        headline6: TextStyle(
          color: Colors.black,
          // fontWeight: FontWeight.,
          fontSize: 10,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        bodyText2: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
      ));
}
