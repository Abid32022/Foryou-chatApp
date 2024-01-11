import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../ChatWithFriend/chat_with_friend_page.dart';
import 'all_contaact_members.dart';

class ChatList extends StatelessWidget {
   ChatList({super.key});

  List<String> name = ["Qasim","Noman"];
  List<String> description = ["Avalible ","buzzy"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.kPrimaryColor,
        onPressed: (){
          Get.to(AllMembers());
        },
        child: Icon(Icons.message),
      ),
      appBar: AppBar(title: CustomText(text: "Chats",color: Colors.white,),centerTitle:
      true,backgroundColor: AppColors.kPrimaryColor,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
                itemCount:name.length,
                itemBuilder: (context,index){
              return ListTile(
                onTap: (){
                  Get.to(MessagingWithFriend(
                    name: name[index],
                  ));
                },
                leading: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.kPrimaryColor,
                  ),
                ),
                title: CustomText(text: name[index]),
                subtitle: CustomText(text: description[index],)
              );
            })
          ],
        ),
      ),
    );
  }
}
