import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrWithDivider extends StatelessWidget {
  Color? orTextColor;
  Color? dividerColor;
  OrWithDivider({this.orTextColor, this.dividerColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Divider(
            height: 1,
            color: dividerColor,
          ),
        ),
        SizedBox(width: 10),
        CustomText(
          text: 'OR',
          color: orTextColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w900,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Divider(
            height: 1,
            color: dividerColor,
          ),
        ),
      ],
    );
  }
}
