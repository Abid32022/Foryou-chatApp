import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  double? height;
  TextAlign? textAlign;
  double? letterSpacing;
  TextOverflow? overflow;

  CustomText(
      {required this.text,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.textAlign,
      this.letterSpacing,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        // overflow: TextOverflow.ellipsis
      ),
    );
  }
}
