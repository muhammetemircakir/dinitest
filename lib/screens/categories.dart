import 'package:dinisorular/models/anaMenuModel.dart';
import 'package:dinisorular/ui/helper/color_helper.dart';
import 'package:dinisorular/ui/styles/box_style.dart';
import 'package:dinisorular/utils/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/homeController.dart';
import '../ui/styles/text_style.dart';


class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  late DatabaseHelper databaseHelper ;
  List<AnaMenu> anaMenu = [] ;
  late double height;
  late double width;
  bool lightThema = true;

  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    anamenuGet();
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
            anaMenu == [] ?CircularProgressIndicator() : Container(
              height: height/100*90,
              width: width,
              child: ListView.builder(
                controller: ScrollController(keepScrollOffset: false),
                padding: EdgeInsets.only(top: 0,bottom: 0,left: width/100*5,right: width/100*5),
                itemBuilder: (context, index) => kategori(index),
                itemCount:anaMenu.length,
              ),
            ),
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
            style: UITextStyle.kategoriText(height/100*5,lightThema ? UIColorThemaLight.TEXT : UIColorThemaDark.TEXT),
      ),
    );
  }

  Container kategori(int id){
    return Container(
      height: height/100*15,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxStyle.boxCategoriesStyle(lightThema),
      child: Text(anaMenu[id].name,style:UITextStyle.kategoriDetailsText(25,lightThema),),
    );
  }

  void anamenuGet()async{
    await databaseHelper.kategoriListesiniGetir().then((value) {
      anaMenu.addAll(value);
    });
    setState(() {

    });
  }

}
