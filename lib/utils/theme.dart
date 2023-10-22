import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RawatinColorTheme {
  static const Color orange = Color(0xFFFD841F);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color secondaryOrange = Color(0xFFFFF1E5);
  static const Color red = Color(0xFFFF0707);
  static const Color grey = Color(0xFF4B4B4B);

  // Primary Text Theme
  static TextTheme primaryTextTheme = TextTheme(
    // Service: DANA Deals, Feed, Whats New, Nearaby: please allow
    headlineMedium: GoogleFonts.notoSans(
      color: orange,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
    ),
    // Appbar: 0,
    headlineSmall: GoogleFonts.notoSans(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: orange,
    ),
    // HeaderWidget: Scan
    titleMedium: GoogleFonts.notoSans(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      color: orange,
    ),
    // Service Card: SERBU!
    titleSmall: GoogleFonts.notoSans(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: orange,
    ),
  );

  static TextTheme secondaryTextTheme = TextTheme(
    // Service: DANA Deals, Feed, Whats New, Nearaby: please allow
    headlineMedium: GoogleFonts.notoSans(
      color: white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
    ),
    // Appbar: 0,
    headlineSmall: GoogleFonts.notoSans(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: white,
    ),
    // HeaderWidget: Scan
    titleMedium: GoogleFonts.notoSans(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      color: white,
    ),
    // Service Card: SERBU!
    titleSmall: GoogleFonts.notoSans(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: white,
    ),
  );
}
