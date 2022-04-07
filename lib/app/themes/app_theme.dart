import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors/light_color.dart';

class AppTheme {
  var lightThemeData = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    backgroundColor: LightColor.background,
    primaryColor: LightColor.yellow2,
    // cardTheme: CardTheme(color: LightColor.navyBlue2),
    iconTheme: IconThemeData(color: LightColor.navyBlue2),
    bottomAppBarColor: LightColor.background,
    dividerColor: LightColor.lightGrey,
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: LightColor.yellow2,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.DWHITE0,
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
