import 'dart:convert';

import 'package:chat_app2/Views/LoginScreen/login_screen.dart';
import 'package:chat_app2/utils/app_constant.dart';
import 'package:chat_app2/utils/app_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SignUpProvider extends ChangeNotifier{
  TextEditingController birthDayEditingController = TextEditingController();
  bool loading = false;
  Future<void> updateStatus({bool? load})async{
    loading = load!;
    notifyListeners();
  }
  Future<void> showEndDatePicker(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(200),
      onDatePickerModeChange: (value) {},
      lastDate: DateTime(3000),
    );

    if (pickedDate != null) {
      birthDayEditingController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      print("this is selcted date ${pickedDate.year}");
      print("this is selcted date ${birthDayEditingController.text}");
      notifyListeners();
      // Provider.of<EditCampaignProvider>(context, listen: false)
      //     .changeEndDAte(selected: pickedDate);
    }
  }
  Future<void> signUp({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? gender,
    String? birthDay,
    String? location,
  })async{
    print("Name: $name");
    print("Email: $email");
    print("Password: $password");
    print("Confirm Password: $confirmPassword");
    print("Gender: $gender");
    print("Birthday: $birthDay");
    print("Location: $location");
    updateStatus(load: true);
    var headers = {
      'Accept': 'application/json',
      // 'Authorization': 'Bearer 2|DP0kcVbPLUIdZIxDS20kfDZcWd4o17xpfzS1d7D67bd7e3f0'
    };
    var data = FormData.fromMap({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'gender': gender,
      'birthday': birthDay,
      'location': location
    });
    print("this is data ${data}");

    var dio = Dio();
    try{
      var response = await dio.request(
        '${AppUrl.baseUrl}${AppUrl.signup}',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map  = response.data;
        print(json.encode(response.data));
        updateStatus(load: false);
        print("this is success response");
        AppConstant.flutterToastSuccess(responseMessage: "Successfully user register");
        // print("this is success token ${map['access_token']}");
        print(" ==========>>>> ${response.data}");
        Get.offAll(()=> LoginScreen());

      }
      else {
        print("this is error");
        updateStatus(load: false);
        print(response.statusMessage);
      }
    }
    on DioException catch (exception) {
      updateStatus(load: false);
      if(exception.response != null){
        String content = exception.response.toString();
        Map<String, dynamic> map = jsonDecode(exception.response.toString());
        if(map['message'] != null){
          AppConstant.flutterToastError(responseMessage:  map['message']);
          print("this is error in dio ${map['message'].toString()}");
        }else if(map['error'] != null){
          // Map<dynamic, String> secondMap = map['error'];
          AppConstant.flutterToastError(responseMessage:  map['error'].toString());
          print("this is error in dio ${map['error'].toString()}");
          print("this signup dio dio ${content}");
        }

      }
      rethrow;
    }
    catch(error){
      updateStatus(load: false);
    }
  }
}