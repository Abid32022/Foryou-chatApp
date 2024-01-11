import 'dart:convert';
import 'package:chat_app2/Views/LoginScreen/login_screen.dart';
import 'package:chat_app2/Views/Profile/Model/profile_model.dart';
import 'package:chat_app2/utils/app_constant.dart';
import 'package:chat_app2/utils/app_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  bool loading = false;
  Future<void> updateStatus({bool? load}) async {
    loading = load!;
    notifyListeners();
  }
  bool logoutLoading = false;
  Future<void> updateLogoutStatus({bool? load}) async {
    loading = load!;
    notifyListeners();
  }
  List<ProfileModel> profileData = [];
  Future<void> getUserProfileData() async {
    print("load profile data ${AppConstant.getUserToken}");
    updateStatus(load: true);
    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${AppConstant.getUserToken}'
    };
    try {
      var dio = Dio();
      var response = await dio.request(
        '${AppUrl.baseUrl}${AppUrl.profile}',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        profileData.clear();
        print("this is profile response ${response.data}");
        Map<String, dynamic> map = response.data;
        print("this is profile response  55 ${response.data}");
        profileData.add(ProfileModel.fromJson(map));
        print("this is profile response 5566 ${response.data}");
        updateStatus(load: false);
        print(json.encode(response.data));
        notifyListeners();
      } else {
        print("this is else ${response.data}");
        updateStatus(load: false);
        print(response.statusMessage);
      }
    } on DioException catch (exception) {
      updateStatus(load: false);
      if(exception.response != null){
        if(exception.response!.statusCode == 401){
          removeUserLocalData();
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
  Future<void> logOut()async{
    updateLogoutStatus(load: true);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppConstant.getUserToken}'
    };
    try{
      var dio = Dio();
      var response = await dio.request(
        "${AppUrl.baseUrl}${AppUrl.logout}",
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        updateLogoutStatus(load: false);
        AppConstant.flutterToastSuccess(responseMessage: "Successfully logout");
        removeUserLocalData();

        print(json.encode(response.data));
      }
      else {
        updateLogoutStatus(load: false);
        print(response.statusMessage);
      }
    }on DioException catch (exception) {
      updateLogoutStatus(load: false);
      if(exception.response != null){
        if(exception.response!.statusCode == 401){
          removeUserLocalData();
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
    }
  }
  Future<void> removeUserLocalData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(AppConstant.saveUserToken);
    prefs.remove(AppConstant.saveUserRule);
    Get.offAll(()=> LoginScreen());
    notifyListeners();
  }
}
