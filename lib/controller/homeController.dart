import 'package:dinisorular/models/anaMenuModel.dart';
import 'package:dinisorular/utils/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePageController extends GetxController {
  DatabaseHelper databaseHelper = DatabaseHelper();

  getThema()
  async{
    // Get.changeTheme(a?ThemeData.light():ThemeData.dark());
  }

  changeThema(bool thema)
  {
    //box.write("thema", thema);
    Get.changeTheme(thema?ThemeData.light():ThemeData.dark());
  }


}