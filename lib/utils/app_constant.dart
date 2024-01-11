import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppConstant{
  static String saveUserID = 'saveUserID';
  static String saveUserToken = 'saveUserToken';
  static String saveUserRule = 'saveUserRule';
  static String getUserID = '';
  static String getUserToken = '';
  static String getUserRule = '';


  static void flutterToastError({required String responseMessage}) {
    Fluttertoast.showToast(
        msg: responseMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  static void flutterToastSuccess({required String responseMessage}) {
    Fluttertoast.showToast(
        msg: responseMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}