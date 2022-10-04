import 'package:dinisorular/aracGerec.dart';
import 'package:dinisorular/controller/testListController.dart';
import 'package:dinisorular/models/kategoriModel.dart';
import 'package:dinisorular/screens/test.dart';
import 'package:dinisorular/utils/DataBaseCevap.dart';
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
  late DatabaseHelper databaseHelper;
  late DataBaseCevap dataBaseCevap;
  testListController controller = Get.put(testListController());


  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    dataBaseCevap = DataBaseCevap();
    controller.kategoriGet(widget.anaMenuId);
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
           Obx(()=>controller.testList.isEmpty ?CircularProgressIndicator() : Container(
             height: height/100*90,
             width: width,
             child: ListView.builder(
               controller: ScrollController(keepScrollOffset: false),
               padding: EdgeInsets.only(top: 0,bottom: height/100*5,left: width/100*5,right: width/100*5),
               itemBuilder: (context, index) => kategori(index),
               itemCount:controller.testList.length,
             ),
           ),)
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
      child: Row(
        children: [
          AracGerec.sizedBox(0.0, width/100*5),
          GestureDetector(
            onTap: Get.back,
            child:Container(
              width: width/100*10,
                child: Icon(Icons.arrow_back_ios,size: height/100*4,color: lightThema?UIColorThemaLight.TEXT:UIColorThemaDark.TEXT,)),
          ),
          AracGerec.sizedBox(0.0, width/100*10),
          Container(
            width: width/100*50,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text(
              widget.anaMenuText,
              style: UITextStyle.baslikText(height/100*5,lightThema ? UIColorThemaLight.TEXT : UIColorThemaDark.TEXT),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector kategori(int id){

    return GestureDetector(
      onTap: (){
        Get.to(Test(anaMenuId:controller.testList.toList()[id].anaMenuId, kategoriId: controller.testList.toList()[id].kategoriId,
        dogru:controller.testList.toList()[id].dogru ,
        yanlis: controller.testList.toList()[id].yanlis,
        bos:controller.testList.toList()[id].bos ,));
      },
      child: Container(
        height: height/100*15,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 15),
        decoration: BoxStyle.boxCategoriesStyle(lightThema),
        child: Column(
          children: [
            AracGerec.sizedBox(height/100*5,0.0),
            Row(
              children: [
                AracGerec.sizedBox(0.0, width/100*35),
                Container(
                  width: width/100*20,
                  alignment: Alignment.center,
                    child: Text("Test "+controller.testList.toList()[id].kategoriId.toString(),style:UITextStyle.testText(height/100*3,lightThema),)
                ),
                AracGerec.sizedBox(0.0, width/100*15),
                controller.testList.toList()[id].acikMi != 0? GestureDetector(
                  onTap: ()async{
                    verileriSifirla(id);
                  },
                  child: Container(
                    height: height/100*5,
                    width: width/100*15,
                    alignment: Alignment.center,
                    child: Icon(Icons.delete,color:lightThema?UIColorThemaLight.TEXT:UIColorThemaDark.TEXT),
                  ),
                ):AracGerec.sizedBox(height/100*5, width/100*15),
                AracGerec.sizedBox(0.0, width/100*5),
              ],
            ),
            controller.testList.toList()[id].acikMi != 0? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height/100*5,
                  color: Colors.transparent,
                  child:Row(
                    children: [
                      Icon(Icons.check_circle,color: lightThema ?UIColorThemaLight.AnswerT_COLOR :UIColorThemaDark.AnswerT_COLOR,size: height/100*3,),
                      AracGerec.sizedBox(0.0, width/100*1),
                      Obx(()=>dogruYanlisText(controller.testList.toList()[id].dogru.toString())),
                      AracGerec.sizedBox(0.0, width/100*2),
                      Icon(Icons.cancel,color: lightThema ?UIColorThemaLight.AnswerF_COLOR :UIColorThemaDark.AnswerF_COLOR,size: height/100*3,),
                      AracGerec.sizedBox(0.0, width/100*1),
                      Obx(()=>dogruYanlisText(controller.testList.toList()[id].yanlis.toString())),
                      AracGerec.sizedBox(0.0, width/100*2),
                      Icon(Icons.circle,color: lightThema ?UIColorThemaLight.AnswerB_COLOR :UIColorThemaDark.AnswerB_COLOR,size: height/100*3,),
                      AracGerec.sizedBox(0.0, width/100*1),
                      Obx(()=>dogruYanlisText(controller.testList.toList()[id].bos.toString())) ,
                    ],
                  ),
                ),
              ],
            ):Container(),
          ],
        ),
      ),
    );
  }
  Text dogruYanlisText(String istatik)
  {
    return Text(istatik,style: UITextStyle.dogruSayi(height/100*2.3, lightThema),);
  }


  verileriSifirla(int id)
  async{
    dataBaseCevap.tumCevapSil(controller.testList.toList()[id].anaMenuId.toString(), controller.testList.toList()[id].kategoriId.toString()).then((value){});
    await databaseHelper.kategoriGuncelle(Kategori(widget.anaMenuId,controller.testList.toList()[id].kategoriId , 0,0,20,0),widget.anaMenuId, controller.testList.toList()[id].kategoriId);
    controller.kategoriGet(widget.anaMenuId);
  }


}
