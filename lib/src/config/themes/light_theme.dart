import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// rgb(135, 131, 138)

ThemeData lightTheme = ThemeData(
    primaryTextTheme: TextTheme(
      headline1: GoogleFonts.roboto(
          fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
      headline2: GoogleFonts.roboto(
          fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
      headline3: GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
      headline4: GoogleFonts.roboto(
          fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headline5: GoogleFonts.roboto(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w400),
      headline6: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15),
      subtitle1: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.15),
      subtitle2: GoogleFonts.roboto(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1),
      bodyText1: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5),
      bodyText2: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25),
      button: GoogleFonts.roboto(
          fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      caption: GoogleFonts.roboto(
          fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      overline: GoogleFonts.roboto(
          fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    ),
    scaffoldBackgroundColor: Colors.grey[50],
    brightness: Brightness.light,
    primaryColor: Color(0xFF059445),
   

    // primaryColor: Color.fromRGBO(135, 131, 138, 1),
    backgroundColor: Colors.white,
    cardColor: Colors.white,
    buttonColor: Colors.grey[200],
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.black,
            letterSpacing: 0,
            fontWeight: FontWeight.w300)),
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: Colors.white,
        textTheme: TextTheme(
            headline6: TextStyle(
          color: Colors.black,
        ))),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.red,
      selectedLabelStyle: TextStyle(color: Colors.red),
      unselectedItemColor: Color.fromRGBO(158, 158, 158, 1),
      unselectedLabelStyle: TextStyle(
        color: Colors.grey[500],
      ),
    ));
