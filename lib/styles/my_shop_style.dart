import 'package:flutter/material.dart';

class MyShopStyle {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Lato",
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.light, // yoki dark
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
    ),
  );
}
