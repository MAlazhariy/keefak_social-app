import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: Colors.blueAccent,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF313131),
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0,
    backgroundColor: Color(0xFF313131),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF313131),
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xC99E9B9B),
  ),
  scaffoldBackgroundColor: const Color(0xFF313131),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 17,
      decorationColor: Colors.white,
      color: Colors.white,
    ),
    headline1: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 23,
      decorationColor: Colors.white,
      color: Colors.white,
    ),
    headline2: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      decorationColor: Colors.white,
      color: Colors.white,
    ),
  ),
);