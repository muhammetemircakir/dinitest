import 'package:dinisorular/aracGerec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../ui/styles/text_style.dart';
import 'categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = Get.height-context.mediaQueryPadding.top;
    double width  = Get.width;

    return Container(
      color: Theme.of(context).backgroundColor,
      child: Container(
        margin: EdgeInsets.only(top:context.mediaQueryPadding.top ),
        child: Column(
          children: [
            Text("SelamunAleyküm ",
              style:Theme.of(context).textTheme.headline3,),
            ElevatedButton(onPressed:(){
              Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
                child: Text("thema")),
            AracGerec.sizedBox(300, 0.0),
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
}
