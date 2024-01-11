import 'dart:convert';

import 'package:chat_app2/utils/app_constant.dart';
import 'package:chat_app2/utils/app_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class LogOutProvider extends ChangeNotifier{
  bool loading = false;
  Future<void> updateStatus({bool? load}) async {
    loading = load!;
    notifyListeners();
  }
  Future<void> logOut()async{
    updateStatus(load: true);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppUrl.logout}'
    };
    try{
      var dio = Dio();
      var response = await dio.request(
        '${AppUrl.baseUrl}${AppUrl.logout}',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
      }
      else {
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