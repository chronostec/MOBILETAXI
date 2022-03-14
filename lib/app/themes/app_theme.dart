import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors/app_colors.dart';

class AppTheme {
  var lightThemeData = ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.montserratTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 211, 210, 210),
      centerTitle: true,
      titleTextStyle: GoogleFonts.montserrat(color: Colors.black),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 32, 31, 31),
      ),
    ),
  );

  var darkThemeData = ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.montserratTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 21, 42, 73),
      centerTitle: true,
      titleTextStyle: GoogleFonts.montserrat(color: Colors.white),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 248, 244, 244),
      ),
    ),
  );
}
