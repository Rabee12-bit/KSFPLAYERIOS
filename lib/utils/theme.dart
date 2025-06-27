import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  scaffoldBackgroundColor: Color(0xFF181A20),
  appBarTheme: AppBarTheme(backgroundColor: Color(0xFF23272F), elevation: 0),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF23272F),
    border: OutlineInputBorder(),
  ),
);
