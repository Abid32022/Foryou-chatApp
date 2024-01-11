import 'package:chat_app2/Provider_Controller/ForgotProvider/forgot_provider.dart';
import 'package:chat_app2/Provider_Controller/SignInProvider/sign_in_provider.dart';
import 'package:chat_app2/Views/Account/account_details.dart';
import 'package:chat_app2/Views/Profile/profile_view.dart';
import 'package:chat_app2/Widgets/custom_button.dart';
import 'package:chat_app2/Widgets/custom_text_btn.dart';
import 'package:chat_app2/Widgets/custom_textfield.dart';
import 'package:chat_app2/Widgets/or_with_divider.dart';
import 'package:chat_app2/Widgets/rounded_container.dart';
import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../ForgotPasswordPage/fotgot_password_page.dart';
import '../Profile/Model/profile_model.dart';
import '../SignUpScreen/sing_up_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key,});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AccountDetails();
  }

  bool visi = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kWhiteColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  text: 'Log in',
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  color: AppColors.kPrimaryColor,
                ),
              ),
              SizedBox(height: 15),
              CustomText(
                textAlign: TextAlign.center,
                text:
                'Welcome back! Sign in using your social account or email to continue us',
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: AppColors.textGreyColor,
                letterSpacing: 0.1,
              ),
              SizedBox(height: 15),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     RoundedContainer(img: AppImages.facebook),
              //     RoundedContainer(img: AppImages.google),
              //     RoundedContainer(
              //       img: AppImages.appleIcon,
              //       color: AppColors.kBlackColor,
              //     ),
              //   ],
              // ),
              SizedBox(height: 10.h),
              // OrWithDivider(
              //   orTextColor: AppColors.textGreyColor,
              // ),
              SizedBox(height: 10.h),
              CustomTextField(
                validator: (value) {},
                labelText: 'Your Email',
                controller: _emailController,
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                onTapDown: (){
                  setState(() {
                    visi = !visi;
                  });
                },
                icon: visi ? Icons.visibility_off : Icons.remove_red_eye,
                obscureText: visi,
                validator: (value)  {},
                labelText: 'Password',
                controller: _passwordController,

              ),
              SizedBox(height: 20,),

              Consumer<ForgotProvider>(
                builder: (context, forgotProvider, child) {
                  return InkWell(
                    onTap: (){
                      Get.to(ForgotPasswordPage());
                    },
                    child: CustomText(text: "Forgot Password?",color:
                    AppColors.kPrimaryColor,fontWeight: FontWeight.w400,),
                  );
                  //   CustomTextButton(
                  //
                  //   loading: forgotProvider.loading,
                  //   btnText: 'Forgot Password?',
                  //   onPressed: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) =>ForgotPasswordPage()));
                  //   },
                  //   fontSize: 14.sp,
                  //   fontWeight: FontWeight.w500,
                  //   color: AppColors.kPrimaryColor,
                  // );
                },
              ),
              SizedBox(height: 10,),
              Consumer<SingInProvider>(
                builder: (context, singInProvider, child) {
                  return CustomButton(
                    loading: singInProvider.loading,
                    btnText: 'Log in',
                    onPressed: () {
                      // Get.to(Profile());
                      // Validate email
                      if (_emailController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Email is required'),
                          ),
                        );
                        return;
                      }
                      final emailRegex =
                      RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                      if (!emailRegex.hasMatch(_emailController.text.trim())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid email format'),
                          ),
                        );
                        return;
                      }

                      // Validate password
                      if (_passwordController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Password is required'),
                          ),
                        );
                        return;
                      }

                      // All validations passed, perform login
                      singInProvider.login(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                    },
                    btnColor: AppColors.kPrimaryColor,
                    btnTextColor: AppColors.kWhiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  );
                },
              ),
              SizedBox(height: 10.h),

              CustomButton(
                btnTextColor: AppColors.kPrimaryColor,
                fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  btnText: "Sign Up", onPressed: (){
                Get.to(()=> SignUpScreen());
              }),
            ],
          ),
        ),
      ),
    );
  }
}