import 'package:dinisorular/aracGerec.dart';
import 'package:dinisorular/models/kategoriModel.dart';
import 'package:dinisorular/screens/test.dart';
import 'package:dinisorular/utils/dbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../models/anaMenuModel.dart';
import '../ui/helper/color_helper.dart';
import '../ui/styles/box_style.dart';
import '../ui/styles/text_style.dart';

class TestList extends StatefulWidget {
  int anaMenuId;
  String anaMenuText;
   TestList({Key? key,required this.anaMenuId,required this.anaMenuText}) : super(key: key);

  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  final box = GetStorage();
  late double height;
  late double width;
  late bool lightThema;
  List<Kategori> testList = [] ;
  late DatabaseHelper databaseHelper;


  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    kategoriGet(widget.anaMenuId);
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
            testlerText(),
            testList == [] ?CircularProgressIndicator() : Container(
              height: height/100*90,
              width: width,
              child: ListView.builder(
                controller: ScrollController(keepScrollOffset: false),
                padding: EdgeInsets.only(top: 0,bottom: height/100*5,left: width/100*5,right: width/100*5),
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
        widget.anaMenuText,
        style: UITextStyle.baslikText(height/100*5,lightThema ? UIColorThemaLight.TEXT : UIColorThemaDark.TEXT),
      ),
    );
  }

  GestureDetector kategori(int id){
    return GestureDetector(
      onTap: (){
        Get.to(Test(anaMenuId:testList[id].anaMenuId, kategoriId: testList[id].kategoriId));
      },
      child: Container(
        height: height/100*15,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 15),
        decoration: BoxStyle.boxCategoriesStyle(lightThema),
        child: Row(
          children: [
            AracGerec.sizedBox(0.0, width/100*35),
            Container(
              width: width/100*20,
              alignment: Alignment.center,
                child: Text("Test "+testList[id].kategoriId.toString(),style:UITextStyle.testText(height/100*3,lightThema),)
            ),
            AracGerec.sizedBox(0.0, width/100*15),
            GestureDetector(
              onTap: (){},
              child: Container(
                height: height/100*15,
                width: width/100*15,
                alignment: Alignment.center,
                child: Icon(Icons.refresh_sharp,color:lightThema?UIColorThemaLight.TEXT:UIColorThemaDark.TEXT),
              ),
            ),
            AracGerec.sizedBox(0.0, width/100*5),
          ],
        ),
      ),
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
