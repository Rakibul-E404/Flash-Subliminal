import 'dart:ui';
import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();


  static TextStyle get defaultTextStyleBlack => TextStyle(
    fontFamily: 'Montserrat-VariableFont_wght',  // Set the font family to 'Plus Jakarta Sans'
    fontSize: 16,           // Default font size
    fontWeight: FontWeight.normal,  // Default font weight
    color: Colors.black,    // Default text color
  );

  static TextStyle get defaultTextStyleWhite => TextStyle(
    fontWeight: FontWeight.normal,
    fontFamily: 'Montserrat-VariableFont_wght',
    fontSize: 16,
    color: Colors.white,
  );

}