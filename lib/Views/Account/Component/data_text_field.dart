import 'package:chat_app2/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DateTextField extends StatelessWidget {
  String labelText;
  String? enable;
  bool obscureText;
  IconData? icon;
  bool? passwordVisible = true;
  String? Function(String?)? validator;
  TextEditingController? controller;
  void Function()? onTap;
  void Function()? onTapDown;

  DateTextField({this.enable,required this.validator,required this
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
      style: TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 4,bottom: 20),
        // suffixStyle: ,
        border: UnderlineInputBorder(
            borderSide: BorderSide.none),
        hintStyle: TextStyle(color: Colors.black),)
        ),
      ],
    );
  }
}