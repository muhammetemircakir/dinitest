import 'package:dinisorular/controller/categoriesController.dart';
import 'package:dinisorular/models/anaMenuModel.dart';
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
    double width  = Get.width;

    return Container(
      color: Theme.of(context).backgroundColor,
      child: Container(
        margin: EdgeInsets.only(top:context.mediaQueryPadding.top ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           anaMenu == [] ?CircularProgressIndicator() : Container(
              height: height/100*70,
              width: width,
              child: ListView.builder(
                controller: ScrollController(keepScrollOffset: false),
                padding: EdgeInsets.only(top: 0,bottom: 0),
                itemBuilder: (context, index) => kategori(index),
                itemCount:anaMenu.length,
              ),
            ),
          ],
        ),
      ),
    );

  }

  Container kategori(int id){
    return Container(
      height: height/100*15,
      width: 250,
      color: Colors.redAccent,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10),
      child: Text(anaMenu[id].name,style:UITextStyle.playButton(25),),
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
