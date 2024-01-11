import 'dart:convert';
import 'package:chat_app2/utils/app_constant.dart';
import 'package:chat_app2/utils/app_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:palm_api/palm_api.dart';
import '../../model/messages_data.dart';

class MessageProvider extends ChangeNotifier {
  String errorText = "I'm not able to help with that, as I'm only a language model. If you believe this is an error, please send us your feedback.";
  TextEditingController sendMessageEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool loading = false;

  Future<void> updateStatus({bool? load}) async {
    loading = load!;
    notifyListeners();
  }
  List<MessagesDataModel> messageData = [];


  void handleError(String errorMessage) {
    updateStatus(load: false);
    print("Error: $errorMessage");
    notifyListeners();
  }

  Future<void> saveRecordInAdminPanel({String? sendRecord,String? messageType}) async {
    print("this is waleed in record  user token ${AppConstant.getUserToken}");
    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${AppConstant.getUserToken}'
    };
    var data = FormData.fromMap({
      'message': sendRecord,
      'type':messageType
    });
    try {
      var dio = Dio();
      var response = await dio.request(
        '${AppUrl.baseUrl}${AppUrl.message}',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print("this is waleed in record 200 ");
        print(json.encode(response.data));
      } else {
        print("this is waleed in record  else ");
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

  void sendChat({String? message}) async {
    updateStatus(load: true);

    print("this is waleed");
    messageData.add(MessagesDataModel(
        text: message.toString(), time: DateTime.now(), isSendByMe: true));
    try {
      final palm =
          TextService(apiKey: AppUrl.palmKey);
      final prompt = TextPrompt(text: message!);
      final response =
          await palm.generateText(model: 'text-bison-001', prompt: prompt);
      updateStatus(load: false);
      String fullResponse = '';
      response.candidates.forEach((candidate) {
        fullResponse = candidate.output;
      });

      if (response.candidates.length != 0) {
        messageData.add(MessagesDataModel(
            text: fullResponse.toString(),
            time: DateTime.now(),
            isSendByMe: false));
        saveRecordInAdminPanel(sendRecord: message.toString(),messageType: "user");
        saveRecordInAdminPanel(sendRecord: fullResponse,messageType: "gpt");
        sendMessageEditingController.clear();
        print("this repsonse is null");
      } else {
        messageData.add(MessagesDataModel(
            text:
            errorText,
            time: DateTime.now(),
            isSendByMe: false));
        saveRecordInAdminPanel(sendRecord: message.toString(),messageType: "user");
        saveRecordInAdminPanel(sendRecord: fullResponse,messageType: "gpt");
        sendMessageEditingController.clear();
      }
      // if(fullResponse != '' || )

      notifyListeners();
    } on Exception catch (e) {
      updateStatus(load: false);
      print('Error generating response: $e');
    } catch (e) {
      updateStatus(load: false);
      print('Unknown error: $e');
    }
  }
}
