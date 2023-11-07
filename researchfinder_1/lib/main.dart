import 'package:flutter/material.dart';
import 'package:researchfinder_1/login_screen.dart';

import 'package:researchfinder_1/selectUniversity.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DropDownButton',
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
