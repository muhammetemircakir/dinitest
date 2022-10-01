import 'package:dinisorular/controller/categoriesController.dart';
import 'package:dinisorular/models/anaMenuModel.dart';
import 'package:dinisorular/screens/testList.dart';
import 'package:dinisorular/ui/helper/color_helper.dart';
import 'package:dinisorular/ui/styles/box_style.dart';
import 'package:dinisorular/utils/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/homeController.dart';
import '../ui/styles/text_style.dart';


class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final box = GetStorage();
  late DatabaseHelper databaseHelper ;
  late double height;
  late double width;
  late bool lightThema;
  categoriesController controller = Get.put(categoriesController());

  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    anamenuGet();
    lightThema = box.read("thema")??true;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

     height = Get.height-context.mediaQueryPadding.top;
     width  = Get.width;

    return Container(
      color:lightThema ? UIColorThemaLight.Thema : UIColorThemaDark.Thema ,
      child: Container(
        margin: EdgeInsets.only(top:context.mediaQueryPadding.top ),
        child: Column(
          children: [
            categoriesText(),
            Obx(()=>controller.categorieList.isEmpty ?CircularProgressIndicator() : Container(
             height: height/100*90,
             width: width,
             child: ListView.builder(
               controller: ScrollController(keepScrollOffset: false),
               padding: EdgeInsets.only(top: 0,bottom: 0,left: width/100*5,right: width/100*5),
               itemBuilder: (context, index) => kategori(index),
               itemCount:controller.categorieList.length,
             ),
           )) ,
          ],
        ),
      ),
    );

  }

  Container categoriesText(){
    return Container(
      height: height/100 * 10,
      width: width,
      alignment: Alignment.center,
      child: Text(
        "Kategori",
            style: UITextStyle.baslikText(height/100*5,lightThema ? UIColorThemaLight.TEXT : UIColorThemaDark.TEXT),
      ),
    );
  }

  GestureDetector kategori(int id){
    return GestureDetector(
      onTap: (){
        Get.to(TestList(anaMenuId: controller.categorieList.toList()[id].id,anaMenuText: controller.categorieList.toList()[id].name,));
      },
      child: Container(
        height: height/100*15,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 15),
        decoration: BoxStyle.boxCategoriesStyle(lightThema),
        child: Text(controller.categorieList.toList()[id].name,style:UITextStyle.kategoriDetailsText(25,lightThema),),
      ),
    );
  }

  void anamenuGet()async{
    await databaseHelper.kategoriListesiniGetir().then((value) {
      controller.categorieList.value = value;
    });

  }

}
