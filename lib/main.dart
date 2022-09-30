import 'package:dinisorular/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData _darkTheme = ThemeData(
        backgroundColor:Color(0xFF3B3B3B),
    );

    ThemeData _lightTheme = ThemeData(
      backgroundColor:  Color(0xFFFFFFFF),
        );

    return GetMaterialApp(
      theme: _lightTheme,
      darkTheme: _darkTheme,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
