import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Users',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
