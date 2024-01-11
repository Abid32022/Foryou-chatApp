import 'package:chat_app2/utils/app_colors.dart';
import 'package:chat_app2/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedContainer extends StatelessWidget {
  String img;
  Color? color;

  RoundedContainer({required this.img, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromRGBO(255, 255, 255, 0.19),
      ),
      child: Center(
        child: Image.asset(
          img,
          height: 36.h,
          width: 46.w,
          color: color,
        ),
      ),
    );
  }
}
