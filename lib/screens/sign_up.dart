import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  void showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text('$message'),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, String password) async {
    try {
      // Response response =
      //     await post(Uri.parse('https://reqres.in/api/login'), body: {
      //   'email': email,
      //   'password': password,
      // });
      Response response =
          await post(Uri.parse('https://reqres.in/api/register'), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        //if (!context.mounted) return;
        var data = jsonDecode(response.body.toString());
        showSnackbar('Sign Up with token ${data['token']}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up POST API'),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'E-mail'),
              controller: emailController,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Password'),
              controller: passwordController,
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                login(emailController.text.toString(),
                    passwordController.text.toString());
              },
              child: Container(
                height: 50,
                child: Center(
                  child: Text('Sign Up'),
                ),
                decoration: BoxDecoration(
                    color: Colors.cyan, borderRadius: BorderRadius.circular(14)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
