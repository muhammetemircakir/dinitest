import 'package:dinisorular/models/kategoriModel.dart';
import 'package:dinisorular/utils/dbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/anaMenuModel.dart';
import '../ui/helper/color_helper.dart';
import '../ui/styles/box_style.dart';
import '../ui/styles/text_style.dart';

class TestList extends StatefulWidget {
  int anaMenuId;
   TestList({Key? key,required this.anaMenuId}) : super(key: key);

  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  late double height;
  late double width;
  bool lightThema = true;
  List<Kategori> testList = [] ;
  late DatabaseHelper databaseHelper;


  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    kategoriGet(widget.anaMenuId);
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
            testlerText(),
            testList == [] ?CircularProgressIndicator() : Container(
              height: height/100*90,
              width: width,
              child: ListView.builder(
                controller: ScrollController(keepScrollOffset: false),
                padding: EdgeInsets.only(top: 0,bottom: 0,left: width/100*5,right: width/100*5),
                itemBuilder: (context, index) => kategori(index),
                itemCount:testList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container testlerText(){
    return Container(
      height: height/100 * 10,
      width: width,
      alignment: Alignment.center,
      child: Text(
        "Testler",
        style: UITextStyle.baslikText(height/100*5,lightThema ? UIColorThemaLight.TEXT : UIColorThemaDark.TEXT),
      ),
    );
  }

  Container kategori(int id){
    return Container(
      height: height/100*15,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxStyle.boxCategoriesStyle(lightThema),
      child: Text(testList[id].kategoriId.toString(),style:UITextStyle.kategoriDetailsText(25,lightThema),),
    );
  }

  void kategoriGet(int id)async{
    await databaseHelper.kategoriGet(id).then((value) {
      testList.addAll(value);
    });
    setState(() {

    });
  }

}
