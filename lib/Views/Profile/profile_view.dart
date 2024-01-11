import 'package:chat_app2/Provider_Controller/ProfileProvider/profile_provider.dart';
import 'package:chat_app2/Views/Account/account_details.dart';
import 'package:chat_app2/Views/InviteFriend/invite_a_friend.dart';
import 'package:chat_app2/Views/LoginScreen/login_screen.dart';
import 'package:chat_app2/Views/Notification/notification_page.dart';
import 'package:chat_app2/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../Widgets/custom_text.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../ChatWithFriend/chat_with_friend_page.dart';
import '../InviteFriend/chat_list_page.dart';
import '../messages/messages.dart';
import 'components/custom_list_tile.dart';

class Profile extends StatefulWidget {
   Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<ProfileProvider>(context, listen: false).getUserProfileData();
      // Add Your Code here.
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        toolbarHeight: 151.h,
        leading: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 25.sp,
              color: AppColors.kWhiteColor,
            ),
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) {
                return profileProvider.profileData.isNotEmpty
                    ? profileProvider.profileData[0].profile!.image != null
                    ? CircleAvatar(
                  radius: 41.r,
                  backgroundImage:
                  NetworkImage(profileProvider.profileData[0].profile!.image.toString()),
                )
                    : CircleAvatar(
                  radius: 41.r,
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                  // backgroundImage: AssetImage(
                  // AppImages.profileImg),
                )
                    : CircleAvatar(
                  radius: 41.r,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            SizedBox(height: 10.h),
            Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) {
                return CustomText(
                  text: profileProvider.profileData.isNotEmpty
                      ? profileProvider.profileData[0].profile!.name
                      .toString()
                      : "",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.kWhiteColor,
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 28.h),
          child: Column(
            children: [
              Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
                return CustomListTile(
                  onPressed: () {
                    String profileImage = "";
                    if(profileProvider.profileData.isNotEmpty){
                      var data = profileProvider.profileData[0].profile!;
                      if(data.image != null){
                        profileImage = data.image!;
                      }
                      Get.to(()=> AccountDetails(
                        profileImage: profileImage,
                        email: data.email,
                        name: data.name,
                        birthDay: data.birthday,
                        gender: data.gender,
                        location: data.location,
                      ));
                    }
                  },
                  circleAvatarIcon: Icons.key_outlined,
                  titleText: "Account",
                  subtitleText: "Change profile details",
                  trailingIcon: Icons.arrow_forward_ios,
                );
              },),
              SizedBox(
                height: 19.sp,
              ),
              CustomListTile(
                onPressed: () {
                  Get.to(NotificationPage());
                },
                circleAvatarIcon: Icons.notifications_none_outlined,
                titleText: "Notifications",
                subtitleText: "permissions",
                trailingIcon: Icons.arrow_forward_ios,
              ),
              SizedBox(
                height: 19.sp,
              ),
              CustomListTile(
                onPressed: () {
                  Get.to(InviteAFriendPage());
                },
                circleAvatarIcon: Icons.people_alt_outlined,
                titleText: "Invite a friend",
                subtitleText: "",
                trailingIcon: Icons.arrow_forward_ios,
              ),

              SizedBox(
                height: AppConstant.getUserRule != "user"? 19.sp : 0,
              ),
              AppConstant.getUserRule != "user"?
              CustomListTile(
                onPressed: () {
                  Get.to(MessagingWithAIScreen());
                },
                circleAvatarIcon: Icons.chat_bubble_outline,
                titleText: "Chat with AI",
                subtitleText: "permissions",
                trailingIcon: Icons.arrow_forward_ios,
              ) :SizedBox(),
              SizedBox(
                height: AppConstant.getUserRule != "user"? 19.sp : 0,
              ),
              AppConstant.getUserRule != "user"?
              CustomListTile(
                onPressed: () {
                  Get.to(ChatList());
                },
                circleAvatarIcon: Icons.person_outline,
                titleText: "Chat with friend",
                subtitleText: "permissions",
                trailingIcon: Icons.arrow_forward_ios,
              ): SizedBox(),
              SizedBox(
                height: 19.sp,
              ),
              Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
                 return ListTile(
                   leading: CircleAvatar(
                     radius: 42.r,
                     backgroundColor: AppColors.circularAvatarColor,
                     child: Center(
                         child: Icon(
                           Icons.logout,
                           size: 24.sp,
                           color: AppColors.circularIconColor,
                         )),
                   ),
                   title: Text("Logout",
                       style: TextStyle(
                         fontSize: 16.sp,
                         fontWeight: FontWeight.w500,
                         color: AppColors.kBlackColor,
                       )),
                   subtitle: Text("",
                       style: TextStyle(
                         fontSize: 12.sp,
                         fontWeight: FontWeight.w400,
                         color: AppColors.textGreyColor,
                       )),
                   trailing: IconButton(
                     onPressed: (){
                       profileProvider.logOut();
                     },
                     icon: profileProvider.logoutLoading ?
                     Center(child: CircularProgressIndicator(),):
                     Icon(Icons.arrow_forward_ios_outlined, size: 20.sp, color: AppColors.kBlackColor),
                   ),
                 );
              },),
            ],
          ),
        ),
      ),
    );
  }
}