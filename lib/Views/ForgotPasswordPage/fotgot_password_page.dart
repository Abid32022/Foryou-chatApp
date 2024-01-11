import 'package:chat_app2/Provider_Controller/ForgotProvider/forgot_provider.dart';
import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/Widgets/custom_textfield.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:chat_app2/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'otp_page.dart';

class ForgotPasswordPage extends StatelessWidget {
   ForgotPasswordPage({super.key});
  TextEditingController emailEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.2),
                CustomText(text: "Forgot",color: AppColors.kPrimaryColor,
                  fontSize: 28,fontWeight: FontWeight.w600,),
                CustomText(text: "Password?",color: AppColors.kPrimaryColor,
                  fontSize:
                28,fontWeight: FontWeight.w600,),
                SizedBox(height: 20,),
                CustomTextField(
                    controller: emailEditingController,
                    validator: (value){}, labelText: "Email"),
                SizedBox(height: MediaQuery.of(context).size.height*0.3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<ForgotProvider>(builder: (context,forgotProvider, child) {
                      return InkWell(
                        onTap: (){
                          if (_isValidEmail(emailEditingController.text.trim())) {
                            forgotProvider.sendCode(email: emailEditingController.text.trim());
                          } else {
                            // Show an error message or handle invalid email case
                            print("Invalid email address");
                            AppConstant.flutterToastError(responseMessage: "Invalid email address");
                          }
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.kPrimaryColor,
                          child: forgotProvider.loading ? Center(child: CircularProgressIndicator()): Icon(Icons.arrow_forward,color: AppColors.kWhiteColor,
                            size: 30,),
                        ),
                      );
                    },)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
   bool _isValidEmail(String email) {
     // Regular expression for a simple email validation
     final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
     return emailRegex.hasMatch(email);
   }
}
