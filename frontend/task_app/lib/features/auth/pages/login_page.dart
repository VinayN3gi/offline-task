import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_app/features/auth/cubit/auth_cubit.dart';
import 'package:task_app/features/auth/pages/signup_page.dart';
import 'package:task_app/features/home/pages/home.dart';
import 'package:task_app/features/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) => const LoginPage());
  }

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn() {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().logIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is AuthUserLoggedIn) {
              Navigator.pushAndRemoveUntil(
                  context, HomePage.route(), (_) => false);
            }
          },
          builder: (context, state) {
            return Padding(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Sign In",
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold)),

                        SizedBox(height: 30),

                        //Email field
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(hintText: 'Email'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Email field cannot be empty";
                            } else if (value.isValidEmail == false) {
                              return "Please enter a valid email address ";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 15),

                        //Password field
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(hintText: 'Password'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Password field cannot be null";
                            } else if (value.length <= 6) {
                              return "Please enter a valid password";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),

                        //Login Button
                        ElevatedButton(
                            onPressed: signIn,
                            child:state is AuthLoading ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ) :const Text(
                              'SIGN IN',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),

                        SizedBox(height: 10),
                        RichText(
                            text: TextSpan(
                                text: "Don't have an account ? ",
                                style: Theme.of(context).textTheme.titleMedium,
                                children: [
                              TextSpan(
                                  text: 'Sign Up',
                                  style:TextStyle(fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()..onTap=(){
                                     Navigator.pushAndRemoveUntil( context, SignupPage.route(), (_) => false);
                                  }
                                  ),
                            ]))
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}
