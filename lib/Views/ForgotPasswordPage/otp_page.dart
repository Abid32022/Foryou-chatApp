import 'package:chat_app2/Provider_Controller/ForgotProvider/forgot_provider.dart';
import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'new_password_page.dart';

class OtpPage extends StatelessWidget {
  String? otpCode,email;
   OtpPage({this.email,this.otpCode,super.key});
  TextEditingController editingController = TextEditingController();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
   static const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
  static const fillColor = Color.fromRGBO(243, 246, 249, 0);
  static const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: borderColor),
    ),
  );
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
                SizedBox(height: MediaQuery.of(context).size.height*0.24),
                CustomText(text: "Otp",color: AppColors.kPrimaryColor,
                  fontSize: 28,fontWeight: FontWeight.w600,),
                // CustomText(text: "Password?",color: AppColors.kPrimaryColor, fontSize: 28,fontWeight: FontWeight.w600,),
                SizedBox(height: 40,),
                Directionality(
                  // Specify direction if desired
                  textDirection: TextDirection.ltr,
                  child: Consumer<ForgotProvider>(builder: (context, forgotProvider, child) {
                    return Pinput(
                      length: 6,
                      controller: pinController,
                      focusNode: focusNode,
                      // androidSmsAutofillMethod:
                      // AndroidSmsAutofillMethod.smsUserConsentApi,
                      // listenForMultipleSmsOnAndroid: true,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      validator: (value) {
                        if(value == otpCode){
                          forgotProvider.verifyPassword(email: email,code: otpCode);
                          print("this is match ");
                        }
                        return value ==  otpCode? null : 'Pin is incorrect';
                      },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                      },
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin:  EdgeInsets.only(bottom: 9),
                            width: 22.w,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(19),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    );
                  },),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<ForgotProvider>(builder: (context, forgotProvider, child) {
                      return  InkWell(
                        onTap: (){
                          forgotProvider.verifyPassword(code: otpCode,email: email);
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.kPrimaryColor,
                          child: forgotProvider.loading ? Center(child: CircularProgressIndicator(),): Icon(Icons.arrow_forward,color: AppColors.kWhiteColor,
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
}
