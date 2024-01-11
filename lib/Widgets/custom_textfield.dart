import 'package:chat_app2/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String labelText;
  String? enable;
  bool obscureText;
  IconData? icon;
  bool? passwordVisible = true;
  String? Function(String?)? validator;
  TextEditingController? controller;
  void Function()? onTap;
  void Function()? onTapDown;

  CustomTextField({this.enable,required this.validator,required this
      .labelText, this.controller,this.onTap,this.obscureText = false,this
      .icon,this.passwordVisible,this.onTapDown});




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          obscureText: obscureText,
          enabled: enable != null ?  false:true,
          onTap: onTap,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textFieldTextColor,
              letterSpacing: 0.1,
            ),
            suffixIcon: InkWell(
                onTap : onTapDown,
                child: Icon(icon)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.borderColor,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.borderColor,
              ),
            ),
            // suffixIcon: Icon(Icons.remove_red_eye)
          ),
        ),
      ],
    );
  }
}