import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blueAccent,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),

  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    // unselectedItemColor: Color(0xC98D8A8A),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 17,
    ),
    headline1: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 23,
      decorationColor: Colors.black,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      decorationColor: Colors.black,
      color: Colors.black,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
);