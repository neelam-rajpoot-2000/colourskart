// ignore_for_file: file_names

import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final double? wordSpacing;
  final TextOverflow? textOverflow;
  final double? letterSpacing;
  final int? maxLines;
  final TextAlign? textAlign;

  const CustomText({Key? key,this.textAlign, required this.text, this.fontWeight, this.fontSize, this.color, this.wordSpacing, this.letterSpacing, this.textOverflow, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(
      fontFamily:'Poppins',
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
    ),
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
