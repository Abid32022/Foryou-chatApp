import 'dart:convert';
import 'dart:io';

import 'package:chat_app2/Provider_Controller/ProfileProvider/profile_provider.dart';
import 'package:chat_app2/utils/app_constant.dart';
import 'package:chat_app2/utils/app_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProfileProvider extends ChangeNotifier {
  TextEditingController birthDayEditingController = TextEditingController();
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  void setSelectedImage(File image) {
    _selectedImage = image;
    notifyListeners();
  }

  Future<void> pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setSelectedImage(File(pickedImage.path));
    }
  }
  bool loading = false;
  Future<void> updateStatus({bool? load})async{
    loading = load!;
    notifyListeners();
  }

  Future<void> updateProfile({required BuildContext context,String? name , String? email, String?location,String? gender, String? birthDay }) async {

    updateStatus(load: true);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppConstant.getUserToken}'
    };
    var data = FormData.fromMap({
      'files': _selectedImage!.path != null ? MultipartFile.fromFile(
          _selectedImage!.path,
          filename: _selectedImage!.path.split('/').last) :"",
      'name': name,
      'email': email,
      'location': location,
      'gender': gender,
      'birthday': birthDay
    });
    try{
      var dio = Dio();
      var response = await dio.request(
        '${AppUrl.baseUrl}${AppUrl.updateProfile}',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        updateStatus(load: false);
        print("profile update ${response.data}");
        Provider.of<ProfileProvider>(context,listen: false).getUserProfileData();
        AppConstant.flutterToastSuccess(responseMessage: "Successfully profile updated");
        print(json.encode(response.data));
      } else {
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
}
