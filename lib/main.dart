import 'package:flutter/material.dart';
import 'package:quotes_for_you_testing/screens/home_page.dart';
import 'package:quotes_for_you_testing/screens/product_page_example.dart';
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
      initialRoute: '/postData',
      routes: {
        '/postData':(context) => const Home(),
        '/userData':(context) => const Home2(),
        '/productData':(context) => const Home3(),
      },
      theme: ThemeData(primarySwatch: Colors.cyan),
    );
  }
}
