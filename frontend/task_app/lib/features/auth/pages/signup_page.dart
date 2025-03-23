import 'package:flutter/material.dart';
import 'package:task_app/features/utils/extensions.dart';

class SignupPage extends StatefulWidget {
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
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
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
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ]))
          ],
        ),
      ),
    ));
  }
}
