import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static const DRED = TextStyle();
}

/// HISTORY TEXT VSTYLE
TextStyle historiqueTextStyle(
    {fw = FontWeight.bold, fs = 20.0, color = Colors.black}) {
  return TextStyle(
    fontWeight: fw,
    fontSize: fs,
    color: color,
  );
}

ButtonStyle elevatedButtonStyle({Color color = Colors.green}) {
  return ElevatedButton.styleFrom(
    primary: color,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
  );
}

ButtonStyle outlinedButtonStyle({Color color = Colors.green}) {
  return OutlinedButton.styleFrom(
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
  );
}

Color blueColor = Color(0xff74D8FE);
Color redColor = Color(0xffED5C5C);
Color softblueColor = Color(0xffBCCCE3);
Color blackColor = Color(0xff000000);
Color whiteColor = Color(0xffFFFFFF);
Color greyColor = Color(0xff82868E);
Color softpurpleColor = Color(0xff9FAEFB);

double edge = 24;

TextStyle regularTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  color: blackColor,
);

TextStyle mediaumTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: blackColor,
);

TextStyle redmediaumTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w700,
  color: redColor,
);

TextStyle softblueTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: softblueColor,
);

TextStyle softpurpleColorTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  color: softpurpleColor,
);

TextStyle blackTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w700,
  color: blackColor,
);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: whiteColor,
);

TextStyle boltwhiteTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w700,
  color: whiteColor,
);

TextStyle greyTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w300,
  color: greyColor,
);

TextStyle blueTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: blueColor,
);
