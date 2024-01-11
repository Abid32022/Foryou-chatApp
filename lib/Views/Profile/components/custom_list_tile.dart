import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/app_colors.dart';

class CustomListTile extends StatelessWidget {
  String titleText;
  String? subtitleText;
  IconData? circleAvatarIcon;
  IconData? trailingIcon;
  Widget? leading;
  void Function()? onPressed;
  CustomListTile(
      {required this.titleText,
      required this.onPressed,
      this.subtitleText,
      this.circleAvatarIcon,
      this.trailingIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
    bool change = false;

    return ListTile(
      leading: CircleAvatar(
        radius: 42.r,
        backgroundColor: AppColors.circularAvatarColor,
        child: Center(
            child: Icon(
          circleAvatarIcon,
          size: 24.sp,
          color: AppColors.circularIconColor,
        )),
      ),
      title: Text(titleText,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.kBlackColor,
          )),
      subtitle: Text(subtitleText!,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGreyColor,
          )),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(trailingIcon, size: 20.sp, color: AppColors.kBlackColor),
      ),
    );
  }
}
