import 'package:dinisorular/aracGerec.dart';
import 'package:dinisorular/controller/testController.dart';
import 'package:dinisorular/models/puanTabloModel.dart';
import 'package:dinisorular/ui/styles/box_style.dart';
import 'package:dinisorular/ui/styles/text_style.dart';
import 'package:dinisorular/utils/DataBaseCevap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../models/sorularModel.dart';
import '../ui/helper/color_helper.dart';
import '../utils/dbHelper.dart';

class Test extends StatefulWidget {
  int anaMenuId;
  int kategoriId;
   Test({Key? key,required this.anaMenuId,required this.kategoriId}) : super(key: key);

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
  late List<Sorular> soruList = [];
  testController controller = Get.put(testController());

  @override
  void initState() {
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
            answersA(),
            AracGerec.sizedBox(height/100*2, 0.0),
            answersB(),
            AracGerec.sizedBox(height/100*2, 0.0),
            answersC(),
            AracGerec.sizedBox(height/100*2, 0.0),
            answersD(),
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
            onTap: Get.back,
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

  GestureDetector answersA()
  {
    return GestureDetector(
      onTap: ()async{
        if(!isaretlimi)
          {
            await setSoruBilgisi(controller.soruLis.toList()[controller.counter.toInt()].soruId.toString(),"a");
            if("a" == controller.soruLis.toList()[controller.counter.toInt()].cevap)
              controller.isaretler[0].value = 1;
            else {
              controller.isaretler[0].value = 2;
              dogruCevapAc();
            }
          }
      },
      child:Obx(()=> Container(
        height: height/100*12,
        width: width/100*90,
        alignment: Alignment.center,
        decoration: BoxStyle.boxAnswerStyle(lightThema,controller.isaretler.toList()[0]),
        child:  Text(controller.soruLis.toList().isEmpty ?"":controller.soruLis.toList()[controller.counter.toInt()].a.toString(),style: UITextStyle.questions(height/100*2.2, lightThema),)),
      ),
    );
  }
  GestureDetector answersB()
  {
    return GestureDetector(
      onTap: ()async{
        if(!isaretlimi)
          {
            await setSoruBilgisi(controller.soruLis.toList()[controller.counter.toInt()].soruId.toString(),"b");

            if("b" == controller.soruLis.toList()[controller.counter.toInt()].cevap)
              controller.isaretler[1].value = 1;
            else {
              controller.isaretler[1].value = 2;
              dogruCevapAc();
            }
          }

      },
      child:Obx(()=> Container(
        height: height/100*12,
        width: width/100*90,
        alignment: Alignment.center,
        decoration: BoxStyle.boxAnswerStyle(lightThema,controller.isaretler.toList()[1]),
        child:  Text(controller.soruLis.toList().isEmpty ?"":controller.soruLis.toList()[controller.counter.toInt()].b.toString(),style: UITextStyle.questions(height/100*2.2, lightThema),)),
      ),
    );
  }
  GestureDetector answersC()
  {
    return GestureDetector(
      onTap: ()async{
        if(!isaretlimi)
          {
            await setSoruBilgisi(controller.soruLis.toList()[controller.counter.toInt()].soruId.toString(),"a");

            if("c" == controller.soruLis.toList()[controller.counter.toInt()].cevap)
              controller.isaretler[2].value = 1;
            else
            {
              controller.isaretler[2].value = 2;
              dogruCevapAc();
            }
          }

      },
      child:Obx(()=>  Container(
        height: height/100*12,
        width: width/100*90,
        alignment: Alignment.center,
        decoration: BoxStyle.boxAnswerStyle(lightThema,controller.isaretler.toList()[2]),
        child: Text(controller.soruLis.toList().isEmpty ?"":controller.soruLis.toList()[controller.counter.toInt()].c.toString(),style: UITextStyle.questions(height/100*2.2, lightThema),)),
      ),
    );
  }
  GestureDetector answersD()
  {
    return GestureDetector(
      onTap: (){
        if(!isaretlimi)
        {
          if("d" == controller.soruLis.toList()[controller.counter.toInt()].cevap) {
            controller.isaretler[3].value = 1;
            print("dogru");
          }
          else
            {
              controller.isaretler[3].value = 2;
              dogruCevapAc();
            }

        }

      },
      child:Obx(()=>  Container(
        height: height/100*12,
        width: width/100*90,
        alignment: Alignment.center,
        decoration: BoxStyle.boxAnswerStyle(lightThema,controller.isaretler.toList()[3]),
        child: Text(controller.soruLis.toList().isEmpty ?"":controller.soruLis.toList()[controller.counter.toInt()].d.toString(),style: UITextStyle.questions(height/100*2.2, lightThema),)),
      ),
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
      soruList.addAll(value);

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
}
