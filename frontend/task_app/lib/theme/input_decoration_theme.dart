import 'package:flutter/material.dart';

final InputDecorationTheme customInputDecoration = InputDecorationTheme(
  contentPadding: const EdgeInsets.all(27),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width:3
                ),
                borderRadius: BorderRadius.circular(10)
              ),


              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3
                ),
                
                borderRadius: BorderRadius.circular(10)
              ),

              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3
                ),
                
                borderRadius: BorderRadius.circular(10)
              ),  

              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.red
                ),

                borderRadius: BorderRadius.circular(10)
              )

);
