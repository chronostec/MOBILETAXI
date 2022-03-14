import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  var lightThemeData = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.DRED1,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.DWHITE0,
      ),
    ),
  );

  var darkThemeData = ThemeData(
    fontFamily: 'Poppins',
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.dark,
    // primaryTextTheme: TextTheme(bodyText1: TextStyle().copyWith()),
  );
}
