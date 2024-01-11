import 'package:chat_app2/Provider_Controller/ForgotProvider/forgot_provider.dart';
import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/Widgets/custom_textfield.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:chat_app2/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../LoginScreen/login_screen.dart';

class NewPasswordPage extends StatefulWidget {
  String? token;
   NewPasswordPage({this.token,super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController = TextEditingController();
  bool visible = false;
  bool visibleConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.2),
                  CustomText(text: "Create ",color: AppColors.kPrimaryColor,
                    fontSize: 28,fontWeight: FontWeight.w600,),
                  CustomText(text: "New Password",color: AppColors
                      .kPrimaryColor,
                    fontSize:
                    28,fontWeight: FontWeight.w600,),
                  SizedBox(height: 20,),
                  CustomTextField(
                    controller: passwordEditingController,
                    onTapDown: (){
                      setState(() {
                        visibleConfirm = !visibleConfirm;
                      });
                    },
                    icon: visibleConfirm ? Icons.visibility_off : Icons.remove_red_eye  ,
                    obscureText: visibleConfirm,
                    validator: (value)  {},
                    labelText: 'Password',
                    // controller: _passwordController,

                  ),
                  CustomTextField(
                    controller: confirmPasswordEditingController,
                    onTapDown: (){
                      setState(() {
                        visible = !visible;
                      });
                    },
                    icon: visible ? Icons.visibility_off : Icons.remove_red_eye  ,
                    obscureText: visible,
                    validator: (value)  {},
                    labelText: 'Confirm password',
                    // controller: _passwordController,

                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Consumer<ForgotProvider>(builder: (context, forgotProvider, child) {
                         return InkWell(
                           onTap: () {
                             // Validate email, password, and confirmPassword before sending code
                             if ( _isValidPassword(passwordEditingController.text.trim())) {
                               if(_isValidConfirmPassword(passwordEditingController.text.trim(), confirmPasswordEditingController.text.trim())){
                                 forgotProvider.resetPassword(token: widget.token,
                                     confirmPassword: confirmPasswordEditingController.text.trim(),
                                     password: passwordEditingController.text.trim());
                               }else{
                                 AppConstant.flutterToastError(responseMessage: "Password does not match");
                               }
                             } else {
                               AppConstant.flutterToastError(responseMessage: "Password must be grater then or equal 8 char");
                             }
                           },
                           child: CircleAvatar(
                             radius: 25,
                             backgroundColor: AppColors.kPrimaryColor,
                             child: forgotProvider.loading
                                 ? Center(child: CircularProgressIndicator())
                                 : Icon(
                               Icons.arrow_forward,
                               color: AppColors.kWhiteColor,
                               size: 30,
                             ),
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
      ),
    );
  }
  bool _isValidPassword(String password) {
    // Add your password validation logic here
    // Example: Check if the password is at least 8 characters long
    return password.length >= 8;
  }

  bool _isValidConfirmPassword(String password, String confirmPassword) {
    // Add your confirm password validation logic here
    // Example: Check if the confirm password matches the password
    return password == confirmPassword;
  }

}
