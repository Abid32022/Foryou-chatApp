import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../ChatWithFriend/chat_with_friend_page.dart';

class AllMembers extends StatelessWidget {
  AllMembers({super.key});

  List<String> name = ["Hamad","Adnan"];
  List<String> description = ["Hello how are you ","hey"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "All Users",color: Colors.white,),
        centerTitle:
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
                        child: Icon(Icons.person,color: AppColors.kWhiteColor,),
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
