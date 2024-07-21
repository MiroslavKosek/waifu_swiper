import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    onSurface: HexColor('#0f1010'),
    surface: HexColor('#f6f6f8'),
    primary: HexColor('#2e3657'),
    secondary: HexColor('#8191cf'),
    tertiary: HexColor('#2b44a6')
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    onSurface: HexColor('#eff0f0'),
    surface: HexColor('#070709'),
    primary: HexColor('#a8b0d1'),
    secondary: HexColor('#303f7e'),
    tertiary: HexColor('#5971d4')
  )
);