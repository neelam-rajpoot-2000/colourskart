import 'package:flutter/material.dart';

class CustomAmount extends StatefulWidget {
    String text;
  String? image;
  int color1;
  int color2;
  int color3;
  
   CustomAmount({super.key,this.image,
    required this.text,required this.color1,required this.color2,required this.color3});

  @override
  State<CustomAmount> createState() => _CustomAmountState();
}

class _CustomAmountState extends State<CustomAmount> {
  @override
  Widget build(BuildContext context) {
      double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration( gradient: LinearGradient(
         
              colors: [
                Color(widget.color1),
                Color(widget.color2),
                Color(widget.color3),
              ],
            )),
    ) ;
  }
}