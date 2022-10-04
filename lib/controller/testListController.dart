import 'package:dinisorular/utils/dbHelper.dart';
import 'package:get/get.dart';

import '../utils/DataBaseCevap.dart';

class testListController extends GetxController {
  late DatabaseHelper databaseHelper = DatabaseHelper();
  var testList = [].obs;

   kategoriGet(int id)async{
    await databaseHelper.kategoriGet(id).then((value) {
      testList.value = value;
    });
  }
}