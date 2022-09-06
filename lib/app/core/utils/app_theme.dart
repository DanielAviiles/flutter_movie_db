import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components_app_theme.dart';


class AppTheme {
  static ThemeData dark() {
    final ThemeData theme = ThemeData(
      fontFamily: 'Gilroy',
      primaryColor: yellowColor,
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
            color:whiteColor),
        headline6:
            TextStyle(fontSize: 36.0, color: whiteColor),
        headline4:
            TextStyle(fontSize: 24.0, color: whiteColor),
        bodyText2:
            TextStyle(fontSize: 14.0, color: blackColor),
        bodyText1: TextStyle(
          fontSize: 12.0,
          color: whiteColor,
          decoration: TextDecoration.underline,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(

        hintStyle: TextStyle(
          color: greyColor,
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: greyColor)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: greyColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: greyColor),
        ),
      ),
      scaffoldBackgroundColor: blackColor,
      bottomAppBarTheme: BottomAppBarTheme(color:blackColor) ,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );

    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: yellowColor,
        secondary: whiteColor,
      ),
    );
  }
}
