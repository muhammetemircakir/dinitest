import 'package:get/get.dart';

class testController extends GetxController {

  var counter = 0.obs;
  var soruLis = [].obs;

  increment(){
    counter++;
  }
  decrease(){
    counter--;
  }
}