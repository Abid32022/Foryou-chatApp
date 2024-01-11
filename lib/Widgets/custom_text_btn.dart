import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  String btnText;
  VoidCallback onPressed;
  double? fontSize;
  bool loading;
  FontWeight? fontWeight;
  Color? color;

  CustomTextButton(
      {required this.btnText,
        required this.loading,
      required this.onPressed,
      this.fontSize,
      this.color,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: loading ? Center(child: CircularProgressIndicator(),) :CustomText(
        text: btnText,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
