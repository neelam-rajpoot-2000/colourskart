import 'package:flutter/material.dart';

import 'customText.dart';

class CustomImage extends StatefulWidget {
  String text;
  String? image;
  Color color; 
    double sizedWidth;
  CustomImage({
    super.key,
    this.image,
    required this.color,
        required this.sizedWidth,
    required this.text,
  });

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.003, horizontal: width * 0.007),
      decoration: BoxDecoration(
        border: Border.all(color:widget.color),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: widget.image!,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 08.0,
            textAlign: TextAlign.start,
          ),
          SizedBox(
          width:widget.sizedWidth,
          ),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Color(0xff0288A5),
              borderRadius: BorderRadius.circular(7),
           
            ),
            child: CustomText(
              text: widget.text,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 08.0,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
