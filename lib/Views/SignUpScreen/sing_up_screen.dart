import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:chat_app2/Provider_Controller/SingUpProvider/sign_up_provider.dart';
import 'package:chat_app2/Views/SignUpScreen/components/select_gender.dart';
import 'package:chat_app2/Views/messages/messages.dart';
import 'package:chat_app2/Widgets/custom_button.dart';
import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/Widgets/custom_textfield.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:chat_app2/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../LoginScreen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];
  TextEditingController _nameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _confirmPasswordController = TextEditingController();

  TextEditingController _genderController = TextEditingController();

  TextEditingController _birthdayController = TextEditingController();

  TextEditingController _locationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool visi = true;
  bool visi1 = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: AppColors.kPrimaryColor,
        backgroundColor: AppColors.kWhiteColor,
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomText(
                  text: 'Sign up with Email',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.kPrimaryColor,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: CustomText(
                    text:
                    'Get chatting with friends and family today by signing up for our chat app!',
                    textAlign: TextAlign.start,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.textGreyColor,
                  ),
                ),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preferred Name is required';
                    }
                    return null;
                  },
                  labelText: 'Preferred Name',
                  controller: _nameController,
                ),
                SizedBox(height: 5.h),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    // Regular expression for validating an Email
                    // This regex checks for a standard email format.
                    final emailRegex =
                    RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Invalid email format';
                    }
                    return null; // Return null if the email is valid
                  },
                  labelText: 'Email',
                  controller: _emailController,
                ),
                SizedBox(height: 5.h),
                CustomTextField(
                  onTapDown: (){
                    setState(() {
                      visi1 = !visi1;
                    });
                  },
                  icon: visi1 ? Icons.visibility_off : Icons.remove_red_eye  ,
                  obscureText: visi1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  labelText: 'Password',
                  controller: _passwordController,
                ),
                SizedBox(height: 5.h),
                CustomTextField(
                  onTapDown: (){
                    setState(() {
                      visi = !visi;
                    });
                  },
                  icon: visi ? Icons.visibility_off : Icons.remove_red_eye  ,
                  obscureText: visi,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password is required';
                    }
                    return null;
                  },
                  labelText: 'Confirm Password',

                  controller: _confirmPasswordController,
                ),
                SizedBox(height: 5.h),
                SelectGender(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Gender is required';
                    }
                    return null;
                  },
                  labelText: 'Gender',
                  onSelected: (String newValue) {
                    print("this select");
                    print("this is new value ${newValue}");
                    _genderController.text = newValue;
                    setState(() {});
                  },
                  genderController: _genderController,
                ),
                SizedBox(height: 5.h),
                Consumer<SignUpProvider>(builder: (context, signUpProvider, child) {
                  return CustomTextField(
                    onTap: () {
                      signUpProvider.showEndDatePicker(context);
                      // showDialog(context: context, builder: (context) {
                      //   return signUpProvider.showEndDatePicker
                      // },)
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'BirthDay is required';
                      }
                      return null;
                    },
                    labelText: 'Birthday',

                    controller: signUpProvider.birthDayEditingController,
                  );
                },),
                SizedBox(height: 5.h),
                CustomTextField(

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Location is required';
                    }
                    return null;
                  },
                  labelText: 'Location',
                  controller: _locationController,
                ),
                SizedBox(height: 15.h),
                Consumer<SignUpProvider>(
                  builder: (context, signUpProvider, child) {
                    return CustomButton(
                      btnText: 'Create an account',
                      loading: signUpProvider.loading,
                      onPressed: () {
                        // Get.to(LoginScreen());
                        if (_formKey.currentState!.validate()) {
                          if (_passwordController.text.trim() ==
                              _confirmPasswordController.text.trim()) {
                            signUpProvider.signUp(
                                password: _passwordController.text.trim(),
                                email: _emailController.text.trim(),
                                name: _nameController.text.trim(),
                                birthDay: signUpProvider.birthDayEditingController.text.trim(),
                                confirmPassword: _confirmPasswordController.text
                                    .trim(),
                                gender: _genderController.text.trim(),
                                location: _locationController.text.trim()
                            );
                          } else {
                            print("confirm pass does not match");
                          }
                        } else {
                          print("please add validation");
                        }
                        print("this is gender value ${_genderController.text
                            .trim()}");
                      },
                      btnColor: AppColors.kPrimaryColor,
                      btnTextColor: AppColors.kWhiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    );
                  },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}