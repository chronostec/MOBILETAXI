import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors/app_colors.dart';
import 'colors/light_color.dart';

class AppTheme {
  var lightThemeData = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    backgroundColor: LightColor.background,
    primaryColor: LightColor.navyBlue1,
    cardTheme: const CardTheme(color: LightColor.navyBlue2),
    iconTheme: const IconThemeData(color: LightColor.navyBlue2),
    bottomAppBarColor: LightColor.background,
    dividerColor: LightColor.lightGrey,
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: LightColor.navyBlue1,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColor.PWHITE0,
      ),
    ),
  );
  var darkThemeData = ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.montserratTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 21, 42, 73),
      centerTitle: true,
      titleTextStyle: GoogleFonts.montserrat(color: Colors.white),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 248, 244, 244),
      ),
    ),
  );
  static TextStyle titleStyle =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle =
      const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);
}
