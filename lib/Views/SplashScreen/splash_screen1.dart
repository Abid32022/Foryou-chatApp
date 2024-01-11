import 'dart:async';

import 'package:chat_app2/Provider_Controller/SplashProvider/splash_provider.dart';
import 'package:chat_app2/Views/SplashScreen/splash_screen2.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../../Widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Provider.of<SplashProvider>(context,listen: false).loadLocalData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      body: Center(
        child: Center(
          child: Image.asset("assets/images/me.jpg"),
        ),
      ),
    );
  }
}


// Container(
// height: 128,
// width: 144.w,
// decoration: BoxDecoration(
// border: Border.all(
// width: 2.w,
// style: BorderStyle.solid,
// color: AppColors.kWhiteColor,
// ),
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// CustomText(
// text: '4',
// fontSize: 72,
// color: AppColors.kWhiteColor,
// fontWeight: FontWeight.w400,
// ),
// Align(
// alignment: Alignment.topCenter,
// child: CustomText(
// text: 'U',
// fontSize: 72,
// color: AppColors.kWhiteColor,
// fontWeight: FontWeight.w400,
// ),
// ),
// ],
// ),
// )