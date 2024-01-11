import 'dart:async';

import 'package:chat_app2/Views/LoginScreen/login_screen.dart';
import 'package:chat_app2/Views/SignUpScreen/sing_up_screen.dart';
import 'package:chat_app2/Widgets/or_with_divider.dart';
import 'package:chat_app2/Widgets/rounded_container.dart';
import 'package:chat_app2/Widgets/custom_button.dart';
import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/Widgets/custom_text_btn.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:chat_app2/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(
  //     Duration(minutes: 30),
  //     () => Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => LoginScreen(),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                CustomText(
                  text: 'Make Your Life A Little Simpler',
                  fontSize: 68.sp,
                  height: 1,
                  fontWeight: FontWeight.w400,
                  color: AppColors.kWhiteColor,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomText(
                  text:
                      'Get advice, suggestions and recommendations based on your data.',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(255, 255, 255, 0.19),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedContainer(
                      img: AppImages.facebook,
                    ),
                    RoundedContainer(
                      img: AppImages.google,
                    ),
                    RoundedContainer(
                      img: AppImages.appleIcon,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                OrWithDivider(
                  dividerColor: AppColors.kWhiteColor,
                  orTextColor: AppColors.kWhiteColor,
                ),
                SizedBox(height: 25.h),
                CustomButton(
                  btnText: 'Sign Up With Email',
                  btnColor: AppColors.kWhiteColor,
                  onPressed: () {
                      Get.to(()=> SignUpScreen());

                  },
                  btnTextColor: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'Existing account?',
                      color: AppColors.kWhiteColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    CustomTextButton(
                      loading: false,
                        btnText: 'Log in',
                        onPressed: () {
                            Get.to(()=> LoginScreen());

                        },
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kWhiteColor),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
