import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_app/features/auth/cubit/auth_cubit.dart';
import 'package:task_app/features/auth/pages/login_page.dart';
import 'package:task_app/features/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) => const SignupPage());
  }

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    formKey.currentState!.validate();
    super.dispose();
  }

  void signUp() {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
          name: nameController.text.trim(),
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
        } else if (state is AuthSignUp) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('SignUp was successfull please log in')));
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sign Up',
                    style: TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold)), //Text

                SizedBox(height: 30),

                //Name form field
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Name field cannot be empty";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 15),

                //Email form field
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email field cannot be empty";
                    } else if (value.isValidEmail == false) {
                      return "Please enter a valid email address ";
                    }
                    return null;
                  },
                ),

                //Password form field
                SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password field cannot be null";
                    } else if (value.length <= 6) {
                      return "Please enter a valid password";
                    }
                    return null;
                  },
                ),

                //Button
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: signUp,
                    child: const Text('SIGN UP',
                        style: TextStyle(fontSize: 16, color: Colors.white))),

                //Bottom Text
                SizedBox(height: 10),
                RichText(
                    text: TextSpan(
                        text: 'Already have an account ? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                      TextSpan(
                          text: 'Sign In',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushAndRemoveUntil(
                                  context, LoginPage.route(), (_) => false);
                            }),
                    ]))
              ],
            ),
          ),
        );
      },
    ));
  }
}
