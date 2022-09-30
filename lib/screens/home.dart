import 'package:dinisorular/aracGerec.dart';
import 'package:dinisorular/controller/homeController.dart';
import 'package:dinisorular/models/anaMenuModel.dart';
import 'package:dinisorular/ui/helper/color_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../ui/styles/text_style.dart';
import 'categories.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomePageController controller = Get.put(HomePageController());
  final box = GetStorage();
  late bool lightThema;


  @override
  void initState() {
    lightThema = box.read("thema")??true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double height = Get.height-context.mediaQueryPadding.top;
    double width  = Get.width;

    return Container(
      color:lightThema ? UIColorThemaLight.Thema : UIColorThemaDark.Thema ,
      child: Container(
        margin: EdgeInsets.only(top:context.mediaQueryPadding.top ),
        child: Column(
          children: [
            AracGerec.sizedBox(300, 0.0),
            ElevatedButton(onPressed:changeThema,
                child:Text("switch")),
            GestureDetector(
              onTap: (){
                Get.to(CategoriesPage());
              },
              child: Stack(
                  children: [
                    Container(
                      width: width/100*100,
                      height: height/100*35,
                      color: Colors.transparent,
                      child: Image.asset("assets/images/basla.png"),
                    ),
                    Container(
                      width: width/100*100,
                      height: height/100*35,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child:  Text("Başla",style:UITextStyle.playButton(height/100*5,false),),
                    ),
                  ],
                ),
              ),

          ],
        ),
      ),
    );
  }
  changeThema()
  {
    lightThema =lightThema?false:true;
    box.write("thema",lightThema);

    setState(() {

    });
  }
}
