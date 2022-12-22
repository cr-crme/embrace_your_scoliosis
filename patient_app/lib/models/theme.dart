import 'package:flutter/material.dart';

const Color _backgroundColor = Color.fromARGB(255, 234, 239, 241);

ThemeData get enjoyYourBraceTheme {
  return ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 114, 184, 212),
      onPrimary: Colors.white,
      secondary: Colors.amber,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.black,
      background: _backgroundColor,
      onBackground: Colors.white,
      surface: _backgroundColor,
      onSurface: Colors.black,
    ),
    scaffoldBackgroundColor: _backgroundColor,
  );
}
