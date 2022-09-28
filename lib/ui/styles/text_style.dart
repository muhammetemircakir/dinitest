import 'package:dinisorular/ui/helper/color_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UITextStyle{

  static TextStyle playButton(double height,bool lightThema) =>
      TextStyle(
          fontSize: height,
          inherit: false,
          color:lightThema ? Color(0xFF3B3B3B):Color(0xFF3B3B3B),
          fontFamily: 'PaytoneOne'
      );


  static TextStyle kategoriText(double height,Color color) =>
      TextStyle(
          fontSize: height,
          inherit: false,
          color:color,
          fontFamily: 'Sansita'
      );

  static TextStyle kategoriDetailsText(double height,bool lightThema) =>
      TextStyle(
          fontSize: height,
          inherit: false,
          color:lightThema ? UIColorThemaLight.TEXT:UIColorThemaDark.TEXT,
          fontFamily: 'Sansita'
      );
}