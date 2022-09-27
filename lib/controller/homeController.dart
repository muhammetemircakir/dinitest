import 'package:get/get.dart';

class HomePageController extends GetxController {
  final count = 0.obs;
  final list = [1.obs,2.obs,3.obs,4.obs,5.obs];
  increment() => count.value++;

  mesajyolla(){
    print("selamunaleyküm");
    print("başlangıç");
    print("selamunaleyküm");
  }

  neoluyoYa(){
    count.value = 0;
  }

  listeGuncelle( int a){

   // list.value =[5,35,6,3,2];
    list[0].value= a;
  }
}