import 'package:applyform/screens/FillForm.dart';
import 'package:applyform/screens/FormData.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

     home: FillForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}
