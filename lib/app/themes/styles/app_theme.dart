import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  var lightThemeData = ThemeData(
    
    // fontFamily: 'Poppins',
    textTheme: TextTheme(
      bodyText1: GoogleFonts.notoMusic(),
      
    ),
    brightness: Brightness.light,
    backgroundColor: AppColor.CWHITE,
    primaryColor: AppColor.CWHITE,
    cardColor: AppColor.CWHITE,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColor.CWHITE,
      elevation: 1,
      modalBackgroundColor: AppColor.CWHITE,
    ),
    iconTheme: IconThemeData(
      color: AppColor.CBLACK,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColor.CWHITE, elevation: 2),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        // backgroundColor:
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.CGREY,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
          // color: AppColor.DWHITE0,
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
