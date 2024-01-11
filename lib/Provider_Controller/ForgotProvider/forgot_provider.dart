import 'dart:convert';

import 'package:chat_app2/Views/ForgotPasswordPage/new_password_page.dart';
import 'package:chat_app2/Views/ForgotPasswordPage/otp_page.dart';
import 'package:chat_app2/Views/LoginScreen/login_screen.dart';
import 'package:chat_app2/utils/app_constant.dart';
import 'package:chat_app2/utils/app_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';

class ForgotProvider extends ChangeNotifier{
  bool loading = false;
  Future<void> updateStatus({bool? load})async{
    loading = load!;
    notifyListeners();
  }
  Future<void> sendCode({String? email })async{
    updateStatus(load: true);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppConstant.getUserToken}'
    };
    var data = FormData.fromMap({
      'email': email
    });
    try{
      var dio = Dio();
      var response = await dio.request(
        '${AppUrl.baseUrl}${AppUrl.sendCode}',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        updateStatus(load: false);
        Map<String, dynamic> map  = response.data;
        AppConstant.flutterToastSuccess(responseMessage: map['message'].toString());
        print("this is code ${map['code']}");
        print(json.encode(response.data));
        Get.off(OtpPage(otpCode: map['code'].toString(),email: email,));
      }
      else {
        updateStatus(load: false);
        print(response.statusMessage);
      }
    } on DioException catch (exception) {
      updateStatus(load: false);
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
      print("this is error un catch ${error}");
      updateStatus(load: false);
    }
  }
  Future<void> verifyPassword({String? email,String? code})async{
    updateStatus(load: true);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppConstant.getUserToken}'
    };
    var data = FormData.fromMap({
      'email': email,
      'code': code
    });

try{
  var dio = Dio();
  var response = await dio.request(
    '${AppUrl.baseUrl}${AppUrl.verifyPassword}',
    options: Options(
      method: 'POST',
      headers: headers,
    ),
    data: data,
  );

  if (response.statusCode == 200) {
    updateStatus(load: false);
    Map<String, dynamic> map  = response.data;
    AppConstant.flutterToastSuccess(responseMessage: "Successfully match your OTP");
    Get.off(()=>NewPasswordPage(token: map['token'].toString(),));
    print(json.encode(response.data));
  }
  else {
    updateStatus(load: false);
    print(response.statusMessage);
  }
} on DioException catch (exception) {
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
  Future<void> resetPassword({String? token, String? password,String? confirmPassword})async{
    updateStatus(load: true);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppConstant.getUserToken}'
    };
    var data = FormData.fromMap({
      'token': token,
      'password': password
    });
    try{
      var dio = Dio();
      var response = await dio.request(
        '${AppUrl.baseUrl}${AppUrl.resetPassword}',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        updateStatus(load: false);
        AppConstant.flutterToastSuccess(responseMessage: "Successfully reset your password");
        print("this is successfully reset password ");
        Get.offAll(()=> LoginScreen());
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

}