import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var darkPrimaryColor = Color.fromARGB(255, 22, 22, 22);
var darkSecondaryColor = Color.fromARGB(255, 134, 134, 134);
ThemeData darkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: darkPrimaryColor,
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: textTheme(),
    colorScheme: colorScheme(),
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    backgroundColor: darkPrimaryColor,
    elevation: 0,
    actionsIconTheme: const IconThemeData(
      color: Color.fromRGBO(158, 158, 158, 1),
    ),
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w600,
      color: const Color.fromRGBO(158, 158, 158, 1),
    ),
  );
}

ColorScheme colorScheme() {
  return ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(2, 173, 36, 1),
      onPrimary: darkPrimaryColor,
      secondary: darkSecondaryColor,
      onSecondary: Color.fromARGB(255, 178, 176, 176),
      error: Colors.red,
      onError: darkPrimaryColor,
      background: darkPrimaryColor,
      onBackground: Colors.black,
      surface: darkPrimaryColor,
      onSurface: Colors.black,
      tertiary: Color.fromARGB(255, 244, 243, 243),
      onTertiary: Colors.orange);
}

TextTheme textTheme() {
  return const TextTheme(
    headline1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 36,
    ),
    headline2: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 22,
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
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),
    bodyText1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      height: 1.75,
      fontSize: 12,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),
    button: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 13,
    ),
    caption: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),
    headlineLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),
    overline: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),
    subtitle1: TextStyle(
      color: Color.fromARGB(255, 152, 152, 152),
      fontWeight: FontWeight.normal,
      fontSize: 16,
    ), // used in form field
    subtitle2: TextStyle(
      color: Color.fromARGB(255, 152, 152, 152),
      fontWeight: FontWeight.normal,
      fontSize: 13,
    ), // used in forms hint text
  );
}
