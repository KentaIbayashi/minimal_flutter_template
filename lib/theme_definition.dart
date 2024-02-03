import 'package:flutter/material.dart';

class ThemeDefinition {
  static const primaryColor = Color.fromARGB(255, 22, 148, 245);

  static final lightTheme = ThemeData(
    colorSchemeSeed: primaryColor,
    searchBarTheme: SearchBarThemeData(
      elevation: MaterialStateProperty.all(1),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor.withOpacity(0.6),
      selectionHandleColor: primaryColor,
    ),
  );

  static final darkTheme = ThemeData(
    colorSchemeSeed: primaryColor,
    searchBarTheme: SearchBarThemeData(
      elevation: MaterialStateProperty.all(1),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor.withOpacity(0.6),
      selectionHandleColor: primaryColor,
    ),
    brightness: Brightness.dark,
  );
}
