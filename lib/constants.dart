import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohamed_mounir_assesment/size_config.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xFF00ACEE),
  dividerColor: const Color(0xFFC4C4C4).withOpacity(0.8),
  hintColor: const Color(0xFFF9F9FB),
  primaryColorLight: const Color(0xFFFFFFFF),
  primaryColorDark: const Color(0xFF000000),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  cardColor: const Color(0xFFF9F9FB),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFFFFF),
    primary: const Color(0xFF00ACEE),
    secondary: const Color(0xFF000000).withOpacity(0.5),
    secondaryContainer: const Color(0xFF000000).withOpacity(0.25),
    primaryContainer: const Color(0xFFF9F9FB),
    tertiary: const Color(0xFFB1B1B1).withOpacity(0.75),
    tertiaryContainer: const Color(0xFFEFEFEF),
  ),
);

ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xff00ACEE),
    primaryColorLight: const Color(0xFF333333),
    primaryColorDark: const Color(0xFFCBE4DE),
    hintColor: const Color(0xFF333333),
    cardColor: const Color(0xFF191b1c),
    scaffoldBackgroundColor: const Color(0xFF191b1c),
    dividerColor: const Color(0xFF333333),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFFFFF),
      primary: const Color(0xFF00ACEE),
      secondary: const Color(0xFFF9F9FB),
      secondaryContainer: const Color(0xFF333333),
      primaryContainer: const Color(0xFFF9F9FB),
      tertiary: const Color(0xFFB1B1B1).withOpacity(0.75),
      tertiaryContainer: const Color(0xFF333333),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    ));

EdgeInsets padding = EdgeInsets.symmetric(
  horizontal: width(20),
  vertical: height(20),
);

BoxShadow boxShadow = BoxShadow(
  color: const Color(0xFF000000).withOpacity(0.1), //color of shadow
  //spread radius
  blurRadius: width(30), // blur radius
  offset: const Offset(0, 8),
);

const userRef = "users";
