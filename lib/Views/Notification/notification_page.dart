import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../Profile/components/custom_list_tile.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "Notification Page",color: Colors.white,),
          backgroundColor: AppColors.kPrimaryColor,centerTitle: true
        ,),
      body: SingleChildScrollView(
        child:Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context,index)
            {
              return CustomListTile(
                onPressed: () {
                },
                circleAvatarIcon: Icons.notifications,
                titleText: "Notifications",
                subtitleText: "permissions",

              );
            })
          ],
        ),
      ),
    );
  }
}
