import 'dart:convert';
// import 'package:get/get.dart';
import 'package:chat_app2/Views/messages/messages.dart';
import 'package:chat_app2/utils/app_constant.dart';
import 'package:chat_app2/utils/app_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingInProvider extends ChangeNotifier{
  bool loading = false;
  Future<void> updateStatus({bool? load})async{
    loading = load!;
    notifyListeners();
  }
  Future<void> login({required String email , required String password})async{
    updateStatus(load: true);
    var headers = {
      'Accept': 'application/json',
    };
    var data = FormData.fromMap({
      'email': email,
      'password': password,
      'fcm_token': '1234'
    });
    try{
      var dio = Dio();
      var response = await dio.request(
        '${AppUrl.baseUrl}${AppUrl.signIn}',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        updateStatus(load: false);
        AppConstant.flutterToastSuccess(responseMessage: "Successfully login");
        // print(json.encode(response.data));
        Map<String, dynamic> map  = response.data;
        prefs.setString(AppConstant.saveUserToken, map['access_token']);
        prefs.setString(AppConstant.saveUserRule, map['user_data']['role'].toString());
        AppConstant.getUserToken = map['access_token'];
        AppConstant.getUserRule = map['user_data']['role'];
        print("this is success response");
        print("this is success token ${map['access_token']}");
        print("this is success user rule  ${map['user_data']['role']}");
        Get.offAll(()=> MessagingWithAIScreen());
      }
      else {
        print("this is error in login ${response.data}");
        updateStatus(load: false);
        print(response.statusMessage);
      }
    }on DioException catch (exception) {
      updateStatus(load: false);
      if(exception.response != null){
        String content = exception.response.toString();
        Map<String, dynamic> map = jsonDecode(exception.response.toString());
        AppConstant.flutterToastError(responseMessage:  map['message']);
        print("this is error in dio ${map['message'].toString()}");
      }
      rethrow;
    }
    catch(error){
      updateStatus(load: false);
    }
  }
  Future<void> signInWithGoogle()async{
    updateStatus(load: true);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppConstant.getUserToken}'
    };
    var data = FormData.fromMap({
      'name': 'zoha',
      'provider_id': '456',
      'email': 'zoha@gmail.com',
      'fcm_token': '2345'
    });

   try{
     var dio = Dio();
     var response = await dio.request(
       '${AppUrl.baseUrl}${AppUrl.signInWithGoogle}',
       options: Options(
         method: 'POST',
         headers: headers,
       ),
       data: data,
     );

     if (response.statusCode == 200) {
       updateStatus(load: false);
       print(json.encode(response.data));
     }
     else {
       updateStatus(load: false);
       print(response.statusMessage);
     }
   }on DioException catch (exception) {
     updateStatus(load: false);
     if(exception.response != null){
       if(exception.response!.statusCode == 401){

         print("this is invalid");
       }
       String content = exception.response.toString();
       Map<String, dynamic> map = jsonDecode(exception.response.toString());
       AppConstant.flutterToastError(responseMessage:  map['message']);
       print("this is error in dio ${map['message'].toString()}");
     }
     rethrow;
   }
   catch(error){
     print("this is errir un catch ${error}");
     updateStatus(load: false);
   }
  }
  Future<void> signInWithFacebook()async{}
  Future<void> signInWithApple()async{}
}