import 'package:dinisorular/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'controller/homeController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData _darkTheme = ThemeData(
        backgroundColor: Color(0xFF3B3B3B),
        brightness: Brightness.dark,
    );

    ThemeData _lightTheme = ThemeData(
        backgroundColor: Color(0xFFFFFFFF),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          disabledColor: Colors.grey,
        ));

    return GetMaterialApp(
      theme:  _lightTheme,
      darkTheme: _darkTheme,
      home: HomePage(),
    );
  }
}
