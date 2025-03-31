import 'package:flutter/material.dart';
import 'package:task_app/features/auth/cubit/auth_cubit.dart';
import 'package:task_app/features/home/pages/home.dart';
import 'package:task_app/theme/elevate_button_theme.dart';
import 'package:task_app/theme/input_decoration_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main(){
 
  runApp(MultiBlocProvider(
    providers: [BlocProvider(create: (_) => AuthCubit())],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task App',
        theme: ThemeData(
          inputDecorationTheme: customInputDecoration,
          elevatedButtonTheme: customButtonTheme,
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthUserLoggedIn) {
              return const HomePage();
            } else {
              return const HomePage();
            }
          },
        ));
  }
}
