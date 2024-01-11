import 'dart:async';
import 'package:chat_app2/Views/SplashScreen/splash_screen2.dart';
import 'package:chat_app2/Views/messages/messages.dart';
import 'package:chat_app2/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Views/LoginScreen/login_screen.dart';

class SplashProvider extends ChangeNotifier{
  Future<void> loadLocalData()async{
    Timer(Duration(seconds: 2), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getString(AppConstant.saveUserToken) != null){
        AppConstant.getUserToken  = prefs.getString(AppConstant.saveUserToken)!;
        AppConstant.getUserRule  = prefs.getString(AppConstant.saveUserRule)!;
        Get.offAll(()=> MessagingWithAIScreen());
        notifyListeners();
      } else{
        Get.offAll(()=>LoginScreen());
      }
      notifyListeners();
    });
  }
}