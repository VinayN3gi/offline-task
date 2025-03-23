import 'package:flutter/material.dart';
import 'package:task_app/features/auth/pages/login_page.dart';
import 'package:task_app/theme/elevate_button_theme.dart';
import 'package:task_app/theme/input_decoration_theme.dart';

void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task App',
      theme: ThemeData(
        inputDecorationTheme:customInputDecoration,
        elevatedButtonTheme: customButtonTheme,
        useMaterial3: true,
      ), 
      home:const LoginPage()
    );
  }
}

