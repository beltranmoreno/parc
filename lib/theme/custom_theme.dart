import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class CustomTheme {
  TextStyle mainFont = GoogleFonts.montserrat();
  TextStyle secondFont = GoogleFonts.openSans();
  TextStyle titleFont = GoogleFonts.mate();
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: CustomColors().darkGreen,
      scaffoldBackgroundColor: CustomColors().darkPale,
      fontFamily: GoogleFonts.montserrat().toString(),
    );
  }
}
