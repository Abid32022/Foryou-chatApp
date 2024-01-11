import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  String btnText;
  Color? btnColor;
  Color? btnTextColor;
  VoidCallback onPressed;
  double? fontSize;
  bool? loading;
  FontWeight? fontWeight;

  CustomButton({
    required this.btnText,
    this.btnColor,
    this.loading,
    this.fontSize,
    this.btnTextColor,
    required this.onPressed,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 48.h,
      minWidth: MediaQuery.of(context).size.width,
      color: btnColor,
      onPressed: onPressed,
      child: loading == true
          ? Center(child: CircularProgressIndicator())
          : CustomText(
              text: btnText,
              color: btnTextColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.kPrimaryColor),
      ),
      elevation: 0,
    );
  }
}
