import 'dart:ui';
import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
  'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color lightDarkColor = hexToColor('#8C8C8C');
  static Color darkColor = hexToColor('#000000');
  static Color whiteColor = hexToColor('#FFFFFF');
  static Color goldenColor = hexToColor('#FFEFC1');
  static Color skyBlueColor = hexToColor('#028BA9');
  static Color pinkColor = hexToColor('#A90270');
  static Color purple1Color = hexToColor('#501B44');
  static Color purple2Color = hexToColor('#26011E');
  static Color greenColor = hexToColor('#23A902');
    static Color lightGreenColor = hexToColor('#5D8706');
    static Color darkPurpleColor = hexToColor('#2D1826');


}
//2D1826