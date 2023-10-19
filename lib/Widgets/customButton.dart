import 'package:flutter/material.dart';

import 'customText.dart';

class CustomButton extends StatefulWidget {
  String text;
  String? selectedtext;
  Color color;
  String? image;
  double heightImage;
  double sizedWidth;

  CustomButton({
    super.key,
    this.image,
    required this.color,
    required this.heightImage,
    required this.sizedWidth,
    this.selectedtext,
    required this.text,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
           vertical: height * 0.003, horizontal: width * 0.007),
      decoration: BoxDecoration(
        border:  Border.all(color:widget.color),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            widget.image!,
            height: widget.heightImage,
            fit: BoxFit.cover,
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
