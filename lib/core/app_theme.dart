import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  appBarTheme: AppBarTheme(backgroundColor: Colors.black),
  primaryColor: Colors.amber,
  secondaryHeaderColor: Colors.amber,
  fontFamily: 'Lato',
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    headline1: TextStyle(
        height: 2,
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.white),
    // textAlign: TextAlign.center,
    headline2: TextStyle(
        height: 2,
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.black12),
    headline3: TextStyle(
        fontFamily: 'Cairo',
        height: 2,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white),

    headline4: TextStyle(
        height: 2,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black26),
  ),
  primarySwatch: Colors.blue,
);
