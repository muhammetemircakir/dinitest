import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UITextStyle{

  static TextStyle playButton(double height) =>
      TextStyle(
          fontSize: height,
          inherit: false,
          color:Color(0xFF3B3B3B),
          fontFamily: 'PaytoneOne'
      );
}