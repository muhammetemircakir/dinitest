import 'package:get/get.dart';

class testController extends GetxController {

  var counter = 0.obs;
  var soruLis = [].obs;
  var cevap = "bos".obs;
  var isaretler = [0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs,0.obs];

  isaretleriSifirla()
  {
    isaretler.toList()[0].value = 0;
    isaretler.toList()[1].value = 0;
    isaretler.toList()[2].value = 0;
    isaretler.toList()[3].value = 0;
  }

  cevapDegis(String cevap1)
  {
    cevap.value = cevap1;
  }

  increment(){
    counter++;
  }
  decrease(){
    counter--;
  }
}