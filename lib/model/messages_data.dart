import 'package:flutter/material.dart';

class MessagesDataModel {
  String text;
  DateTime time;
  bool isSendByMe;

  MessagesDataModel(
      {required this.text, required this.time, required this.isSendByMe});
}



class MessagesData {
  String text;
  DateTime time;
  bool isSendByMe;

  MessagesData(
      {required this.text, required this.time, required this.isSendByMe});
}