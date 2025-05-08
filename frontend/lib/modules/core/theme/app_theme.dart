import 'package:flutter/material.dart';
import 'package:frontend/modules/core/theme/color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  /*
  textTheme: GoogleFonts.inriaSerifTextTheme(
    ThemeData.light().textTheme,
  ),
  */
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
);