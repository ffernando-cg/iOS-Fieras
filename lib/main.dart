import 'package:flutter/material.dart';
import 'package:navigation_practice/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Practice',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
