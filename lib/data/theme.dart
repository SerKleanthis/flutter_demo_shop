import 'package:flutter/material.dart';

ThemeData myThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.italic,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
