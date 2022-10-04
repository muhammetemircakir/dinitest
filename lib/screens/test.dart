import 'package:dinisorular/aracGerec.dart';
import 'package:dinisorular/controller/testController.dart';
import 'package:dinisorular/models/dogruYanlisTablodModel.dart';
import 'package:dinisorular/models/kategoriModel.dart';
import 'package:dinisorular/models/puanTabloModel.dart';
import 'package:dinisorular/ui/styles/box_style.dart';
import 'package:dinisorular/ui/styles/text_style.dart';
import 'package:dinisorular/utils/DataBaseCevap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/testListController.dart';
import '../models/sorularModel.dart';
import '../ui/helper/color_helper.dart';
import '../utils/dbHelper.dart';

class Test extends StatefulWidget {
  int anaMenuId;
  int kategoriId;
  int dogru;
  int yanlis;
  int bos;
   Test({Key? key,required this.anaMenuId,required this.kategoriId,required this.dogru,required this.yanlis,required this.bos}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final box = GetStorage();
  late DatabaseHelper databaseHelper;
  late DataBaseCevap dataBaseCevap;
  late double height;
  late double width;
  late bool lightThema;
  late bool isaretlimi = false;

  int dogru = 0;
  int yanlis = 0;
  int bos = 0;
  testController controller = Get.put(testController());
  testListController controller1 = Get.find();

  @override
  void initState() {
    dogru = widget.dogru;
    yanlis = widget.yanlis;
    bos = widget.bos;
    print(bos);
    databaseHelper = DatabaseHelper();
    dataBaseCevap  = DataBaseCevap();
    getSorular();
    lightThema = box.read("thema")??true;

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
            backPage(),
            question(),
            AracGerec.sizedBox(height/100*5, 0.0),
            Obx(()=>answersA("a",0,controller.soruLis.toList().isEmpty ?"":controller.soruLis.toList()[controller.counter.toInt()].a.toString())),
            AracGerec.sizedBox(height/100*2, 0.0),
            Obx(()=>answersA("b",1,controller.soruLis.toList().isEmpty ?"":controller.soruLis.toList()[controller.counter.toInt()].b.toString())),
            AracGerec.sizedBox(height/100*2, 0.0),
            Obx(()=>answersA("c",2,controller.soruLis.toList().isEmpty ?"":controller.soruLis.toList()[controller.counter.toInt()].c.toString())),
            AracGerec.sizedBox(height/100*2, 0.0),
            Obx(()=>answersA("d",3,controller.soruLis.toList().isEmpty ?"":controller.soruLis.toList()[controller.counter.toInt()].d.toString())),
            AracGerec.sizedBox(height/100*4, 0.0),
            navigationBar(),
          ],
        ),
      ),
    );
  }

  Container backPage(){
    return Container(
      height: height/100*10,
      width: width,
      color: Colors.cyan.withOpacity(0.0),
      margin: EdgeInsets.only(left: width/100*5),
      child: Row(
        children: [
          GestureDetector(
            onTap:(){
              Get.back();
            } ,
            child:Icon(Icons.arrow_back_ios,size: height/100*4,color: lightThema?UIColorThemaLight.TEXT:UIColorThemaDark.TEXT,),
          ),
        ],
      ),
    );
  }

  Container question()
  {
    return Container(
      height: height/100*15,
      width: width/100*90,
      alignment: Alignment.center,
      decoration: BoxStyle.boxQuestionStyle(lightThema),
      child: Obx(()=> Text(controller.soruLis.toList().isEmpty ?"":controller.soruLis.toList()[controller.counter.toInt()].soru.toString(),style: UITextStyle.questions(height/100*2.2, lightThema),)),
    );
  }

  GestureDetector answersA(String sik,int id,String answer)
  {
    return GestureDetector(
      onTap: ()async{


        if(!isaretlimi)
          {
            await setSoruBilgisi(controller.soruLis.toList()[controller.counter.toInt()].soruId.toString(),sik);

            if(sik == controller.soruLis.toList()[controller.counter.toInt()].cevap)
             {
               dogru++;
               bos--;
               print(bos);
               controller.isaretler[id].value = 1;
             }
            else {
              yanlis++;
              bos--;
              print(bos);
              controller.isaretler[id].value = 2;
              dogruCevapAc();
            }
            setDogruYanlisSayi();
            isaretlimi = true;
          }
      },
      child:Container(
        height: height/100*12,
        width: width/100*90,
        alignment: Alignment.center,
        decoration: BoxStyle.boxAnswerStyle(lightThema,controller.isaretler.toList()[id]),
        child:  Text(answer,style: UITextStyle.questions(height/100*2.2, lightThema),)),

    );
  }

  Container navigationBar()
  {
    return Container(
      height: height/100*12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(()=>controller.counter.toInt() != 0 ?GestureDetector(
            onTap:(){
              controller.decrease();
              getSoruBilgisi(controller.soruLis.toList()[controller.counter.toInt()].soruId.toString());
            },
            child:Icon(Icons.arrow_back_ios,size: height/100*4,color: lightThema?UIColorThemaLight.TEXT:UIColorThemaDark.TEXT,),
          ) :GestureDetector(
            onTap:(){},
            child:Icon(Icons.arrow_forward_ios,size: height/100*4,color:Colors.transparent,),
          ) ),
          AracGerec.sizedBox(0.0, width/100*15),
          Obx(()=>Text((controller.counter.toInt()+1).toString()+"/"+controller.soruLis.length.toString(),style:UITextStyle.counter(height/100*3, lightThema),)),
          AracGerec.sizedBox(0.0, width/100*15),
          Obx(()=> controller.counter.toInt() != controller.soruLis.length.toInt()-1 ?GestureDetector(
            onTap:(){
              controller.increment();
              getSoruBilgisi(controller.soruLis.toList()[controller.counter.toInt()].soruId.toString());
            },
            child:Icon(Icons.arrow_forward_ios,size: height/100*4,color: lightThema?UIColorThemaLight.TEXT:UIColorThemaDark.TEXT,),
          ):
          GestureDetector(
            onTap:(){},
            child:Icon(Icons.arrow_forward_ios,size: height/100*4,color:Colors.transparent,),
          )),
        ],
      ),
    );
  }
  void getSorular()async
  {
    databaseHelper.sorularGet(widget.anaMenuId,widget.kategoriId).then((value){
      controller.soruLis.value = value;
      getSoruBilgisi(controller.soruLis.toList()[controller.counter.toInt()].soruId.toString());
    });
  }
  cevaplarRenk() {
    String anlikCevap = controller.soruLis.toList()[controller.counter.toInt()].cevap.toString();
    controller.isaretleriSifirla();
    if (controller.cevap.toString() != "bos")
      {
        if(anlikCevap =="a")
          controller.isaretler.toList()[0].value = 1;
        else if(anlikCevap =="b")
          controller.isaretler.toList()[1].value = 1;
        else if(anlikCevap =="c")
          controller.isaretler.toList()[2].value = 1;
        else if(anlikCevap =="d")
          controller.isaretler.toList()[3].value = 1;

        if(controller.cevap.toString() != anlikCevap)
          {
            if(controller.cevap.toString() == "a")
              controller.isaretler.toList()[0].value = 2;
            if(controller.cevap.toString() == "b")
              controller.isaretler.toList()[1].value = 2;
            if(controller.cevap.toString() == "c")
              controller.isaretler.toList()[2].value = 2;
            if(controller.cevap.toString() == "d")
              controller.isaretler.toList()[3].value = 2;
          }

      }

  }

  dogruCevapAc(){
    String anlikCevap = controller.soruLis.toList()[controller.counter.toInt()].cevap.toString();

    if(anlikCevap =="a")
      controller.isaretler.toList()[0].value = 1;
    else if(anlikCevap =="b")
      controller.isaretler.toList()[1].value = 1;
    else if(anlikCevap =="c")
      controller.isaretler.toList()[2].value = 1;
    else if(anlikCevap =="d")
      controller.isaretler.toList()[3].value = 1;
  }

  getSoruBilgisi(String soruId){
    dataBaseCevap.soruBilgsiniGetir(soruId).then((value)
    {
      if(value.isEmpty)
      {
        isaretlimi = false;
        controller.cevapDegis("bos");

        print("cevap yok");
      }
      else
      {
          controller.cevapDegis(value[0].cevap.toString());
          isaretlimi = true;
          print("cevap : "+value[0].cevap.toString());
        }
      cevaplarRenk();
    });
  }


  setSoruBilgisi(String soruId,String cevap)
  async{
   await dataBaseCevap.cevapEkle(PuanTablo(widget.anaMenuId.toString(),widget.kategoriId.toString(),soruId, cevap));

  }

  setDogruYanlisSayi() async
  {
    await databaseHelper.kategoriGuncelle(Kategori(widget.anaMenuId,widget.kategoriId,dogru , yanlis, bos,1),widget.anaMenuId,widget.kategoriId).then((value){

    });
    controller1.kategoriGet(widget.anaMenuId);
  }


}
