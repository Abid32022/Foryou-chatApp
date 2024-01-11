import 'package:chat_app2/Views/Profile/components/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';

import '../../Widgets/custom_text.dart';
import '../../utils/app_colors.dart';
import '../ChatWithFriend/chat_with_friend_page.dart';

class InviteAFriendPage extends StatelessWidget {
   InviteAFriendPage({super.key});

  List<Invitation> data = [
    Invitation(name: "Friend",description: "Hey",Icons: Icons.share, onPressed: (){Share.share("Hey how are you");}),
    Invitation(name: "Friend",description: "Hey",Icons: Icons.share, onPressed: (){Share.share("Hey how are you");}),
    Invitation(name: "Friend",description: "Hey",Icons: Icons.share, onPressed: (){Share.share("Hey how are you");}),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Invitation Page",color: Colors
          .white,),
        backgroundColor: AppColors.kPrimaryColor,centerTitle: true
        ,),


      body: SingleChildScrollView(
        child:Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context,index){
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 42.r,
                      backgroundColor: AppColors.tileColor,
                      child: Icon(Icons.person_outline,color: AppColors.circularIconColor,),
                    ),
                    title: CustomText(text: data[index].name),
                    subtitle: CustomText(text: data[index].description),
                    trailing: InkWell(
                        onTap: data[index].onPressed,
                        child: Icon(data[index].Icons)),
                  );
                  //   CustomListTile(
                  //   onPressed: () {
                  //   },
                  //   circleAvatarIcon: Icons.notifications,
                  //   titleText: "Friend",
                  //   subtitleText: "permissions",
                  //   trailingIcon: Icons.share,
                  // );
            }),
          ],
        ),
      ),
    );
  }
}



class Invitation{
  String name;
  String description;
  IconData Icons;
  VoidCallback onPressed;

  Invitation({required this.name,required this.description,required this.Icons, required this.onPressed});
}



