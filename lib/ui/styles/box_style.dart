
import 'package:dinisorular/ui/helper/color_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoxStyle {
  static BoxDecoration playButton() =>
      BoxDecoration(
        color: Color(0xFFFF5800),
        borderRadius: BorderRadius.all( Radius.circular(1000)),
      );

  static BoxDecoration boxCategoriesStyle(bool lightThema) => BoxDecoration(

    borderRadius: BorderRadius.all(Radius.circular(25)),
    boxShadow: [
      BoxShadow(
          color:lightThema?Color(0xFFD7D7D7):Color(0xFF2B2B2B) ,
          blurRadius: 5,
          spreadRadius: 1.0,
          offset: Offset(
            0,
            0,
          )),
    ],
    color:lightThema ?UIColorThemaLight.KategoriBox :UIColorThemaDark.KategoriBox,
    //color: Color(0xFFF3F1F1),

    // border: Border.all(color: Colors.grey.shade700, width: 1),

  );

  static BoxDecoration boxQuestionStyle(bool lightThema) => BoxDecoration(

    borderRadius: BorderRadius.all(Radius.circular(25)),
    boxShadow: [
      BoxShadow(
          color:lightThema?Color(0xFFD7D7D7):Color(0xFF2B2B2B) ,
          blurRadius: 5,
          spreadRadius: 1.0,
          offset: Offset(
            0,
            0,
          )),
    ],
    color:lightThema ?UIColorThemaLight.KategoriBox :UIColorThemaDark.KategoriBox,
    //color: Color(0xFFF3F1F1),

    // border: Border.all(color: Colors.grey.shade700, width: 1),

  );

  static BoxDecoration boxAnswerStyle(bool lightThema,RxInt isaret)
      {
        Color color =lightThema ?Color(0xFFFFFFFF) :Color(0xFF444444);
        if(isaret.toInt() == 1)
         color=  lightThema ?Color(0xFF5FE775) :Color(0xFF30AC22);
        if(isaret.toInt() == 2)
          color= Color(0xFFFF6767);
        return BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color:lightThema?Color(0xFFD7D7D7):Color(0xFF2B2B2B) ,
                blurRadius: 5,
                spreadRadius: 1.0,
                offset: Offset(
                  1,
                  5,
                )),
          ],
          color:color ,
          //color: Color(0xFFF3F1F1),

          // border: Border.all(color: Colors.grey.shade700, width: 1),
        );
      }




}