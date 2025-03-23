import 'package:flutter/material.dart';

final ElevatedButtonThemeData customButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: Size(double.infinity,60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
    )
);
