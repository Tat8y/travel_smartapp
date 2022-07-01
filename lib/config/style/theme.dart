import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_smartapp/config/constatnts.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: Colors.grey.shade100,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle.light),
);

ThemeData darkTheme = ThemeData(
  primaryColor: kPrimaryColor,
  //scaffoldBackgroundColor: lightOrange,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
);
