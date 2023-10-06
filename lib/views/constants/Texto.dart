import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    )
  );
}

TextStyle get tituloStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 21,
      fontWeight: FontWeight.bold,
    )
  );
}

TextStyle get subTituloStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    )
  );
}
