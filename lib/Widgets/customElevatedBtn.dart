import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedBtn extends StatelessWidget {
  CustomElevatedBtn({super.key,required this.onPressed,required this.text, required this.loading});
  void Function()? onPressed;
  bool loading;
  String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
          onPressed: onPressed,
          child: loading ? Center(child: CircularProgressIndicator(),): CustomText(
            text: text,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,

          ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13)
          )
        ),
      ),
    );
  }
}
