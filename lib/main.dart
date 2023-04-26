import 'package:flutter/material.dart';
import 'package:quotes_for_you_testing/screens/home_page.dart';
import 'package:quotes_for_you_testing/screens/user_example_2_home.dart';
// import 'data/get_value.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API test',
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: const Home2(),
    );
  }
}
