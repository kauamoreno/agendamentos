//ARQUIVO PARA FACILITAR O USO DE TEMAS NA PAGINA DE CALENDARIO

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


const Color azulClr = Color(0xFF4e5ae8);
const Color amareloClr = Color(0xFFFFB746);
const Color rosaClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = azulClr;
const Color cinzaEscuroClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0XFF424242);

//CLASSE TEMAS USADO PARA FAZER A TROCA DE CORES DA TELA HOME
class Temass {
  static final light = ThemeData(
      backgroundColor: Colors.white,
      primaryColor: primaryClr,
      brightness: Brightness.light
  );

  static final dark = ThemeData(
      backgroundColor: cinzaEscuroClr,
      primaryColor: cinzaEscuroClr,
      brightness: Brightness.dark 
  );
}

//SUBHEADINGSTYLE USADO PARA RETORNAR UM TEXT DE ACORDO COM O ESTILO QUE QUEREMOS
TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.black,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : Colors.black,
    )
  );
}

TextStyle get tituloStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : Colors.black,
    )
  );
}

TextStyle get subTituloStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
    )
  );
}
