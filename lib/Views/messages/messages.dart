import 'dart:async';
import 'dart:convert';

import 'package:chat_app2/Provider_Controller/Messageprovider/messageProvider.dart';
import 'package:chat_app2/Views/Profile/Model/profile_model.dart';
import 'package:chat_app2/Views/Profile/profile_view.dart';
import 'package:chat_app2/Views/messages/components/message_input_textfield.dart';
import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class MessagingWithAIScreen extends StatefulWidget {
  @override
  State<MessagingWithAIScreen> createState() => _MessagingWithAIScreenState();
}

class _MessagingWithAIScreenState extends State<MessagingWithAIScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    continuousScroll();

  }


  void continuousScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(scrollController.hasClients){
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration:Duration(milliseconds: 300), curve:
            Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (WidgetsBinding.instance!.window.viewInsets.bottom > 0.0) {
      // scrollToLatestMessage();
    } else {}
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kWhiteColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
              icon: Icon(Icons.account_circle_outlined,
                  size: 40, color: AppColors.kPrimaryColor),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Consumer<MessageProvider>(builder: (context,
          messageProvider, child) {
        return Padding(
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            margin: EdgeInsets.only(left: 13, right: 13),
            height: 40.h,
            child: MessageInputTextField(
              loading: messageProvider.loading,
              onPressed: (){
                if(messageProvider.sendMessageEditingController.text.length >=2){
                  messageProvider.sendChat(message: messageProvider.sendMessageEditingController.text.trim());
                }else{
                  print("please enter some valid data ");
                }
              },
              messageController: messageProvider.sendMessageEditingController,
            ),
          ),
        );
      },),
      body: Consumer<MessageProvider>(builder: (context, messageProvider,
          child) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: messageProvider.messageData.length != 0 ?
                  ListView.builder(
                    // controller: scrollController,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: messageProvider.messageData.length,
                    itemBuilder: (context, index,) {
                      continuousScroll();

                      return Column(
                        children: [
                          Align(
                            alignment: messageProvider.messageData[index].isSendByMe == false
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: messageProvider.messageData[index].isSendByMe == false
                                    ? AppColors.receiveContainerColor
                                    : AppColors.kPrimaryColor,
                              ),
                              child: CustomText(
                                text: messageProvider.messageData[index].text,
                                color: messageProvider.messageData[index].isSendByMe == false
                                    ? AppColors.kBlackColor
                                    : AppColors.kWhiteColor,
                              ),
                            ),
                          ),
                          messageProvider.messageData[index].isSendByMe ==
                              false ?Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: ()async {
                                    await Clipboard.setData(ClipboardData
                                      (text: messageProvider
                                        .messageData[index].text
                                    )).then((_){
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content:
                                      Text("Text are copied")));
                                    });
                                  },
                                  child: Icon(Icons.copy_rounded,size: 20,)),
                              SizedBox(width: 4,),
                              GestureDetector(
                                  onTap: () {
                                    Share.share(messageProvider
                                        .messageData[index].text);
                                  },
                                  child: Icon(Icons.share_rounded,size: 20,)),
                            ],
                          ): SizedBox.shrink(),
                          Align(
                            alignment: messageProvider.messageData[index].isSendByMe == true
                                ? Alignment.centerRight
                                : Alignment.bottomCenter,
                            child: CustomText(
                              text: DateFormat.jm().format(
                                DateFormat("hh:mm:ss").parse("14:15:00"),
                              ),
                            ),
                          ),
                        ],
                      );

                    },
                  ):
                  Center(child: Text("Response is empty"),),
                ),
              ],
            ),
          ),
        );
      },),
    );
  }
}