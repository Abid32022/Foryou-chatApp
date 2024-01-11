import 'dart:io';

import 'package:chat_app2/Provider_Controller/UpdateProfile/update_profile_provider.dart';
import 'package:chat_app2/Views/Account/Component/data_text_field.dart';
import 'package:chat_app2/Widgets/customElevatedBtn.dart';
import 'package:chat_app2/Widgets/custom_text.dart';
import 'package:chat_app2/Widgets/custom_text_btn.dart';
import 'package:chat_app2/Widgets/custom_textfield.dart';
import 'package:chat_app2/Widgets/editable_custom_textfield.dart';
import 'package:chat_app2/utils/app_colors.dart';
import 'package:chat_app2/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AccountDetails extends StatefulWidget {
  String? name, email,location,gender,birthDay,profileImage;
  AccountDetails(
      {super.key,this.name,this.profileImage,this.email,this.location,this.gender,this.birthDay});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  bool editName = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  // TextEditingController birthdayController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    nameController.text= widget.name!;
    emailController.text= widget.email!;
    locationController.text= widget.location!;
    genderController.text= widget.gender!;
    Provider.of<UpdateProfileProvider>(context,listen: false).birthDayEditingController.text = widget.birthDay!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        title: CustomText(
          text: "Account Details",
        ),
        centerTitle: true,
        foregroundColor: AppColors.kWhiteColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Consumer<UpdateProfileProvider>(builder: (context, updateProfileProvider, child) {
                    return ClipOval(
                      child: GestureDetector(
                        onTap: (){
                          updateProfileProvider.pickImageFromGallery();
                        },
                        child:updateProfileProvider.selectedImage != null ?
                        Container(height: 100,width: 100,decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                          child: Image.file(File(updateProfileProvider.selectedImage!.path),fit: BoxFit.cover,),
                        ) :  widget.profileImage != "" ?                         Container(height: 100,width: 100,decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                          child: Image.network(widget.profileImage!,fit: BoxFit.cover,),
                        ): Container(
                          height: 100,width: 100,decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.borderColor
                        ),
                          child: Icon(Icons.add),
                        ),
                      ),
                    );
                  },),
                ),
                CustomText(
                  text: "Preferred Name",
                  color: AppColors.textGreyColor,
                ),
                EditCustomField(controller: nameController),
                CustomText(
                  text: "Email Address",
                  color: AppColors.textGreyColor,
                ),
                EditCustomField(controller: emailController),
                CustomText(
                  text: "Location",
                  color: AppColors.textGreyColor,
                ),
                EditCustomField(controller: locationController),

                CustomText(
                  text: "Gender",
                  color: AppColors.textGreyColor,
                ),
                EditCustomField(controller:genderController),
                CustomText(
                  text: "Birthday",
                  color: AppColors.textGreyColor,
                ),
                Consumer<UpdateProfileProvider>(builder: (context, updateProfileProvider, child) {
                  return DateTextField(
                    onTap: () {
                      updateProfileProvider.showEndDatePicker(context);
                      // showDialog(context: context, builder: (context) {
                      //   return signUpProvider.showEndDatePicker
                      // },)
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'BirthDay is required';
                      }
                      return null;
                    },
                    labelText: 'Birthday',

                    controller: updateProfileProvider.birthDayEditingController,
                  );
                },),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Consumer<UpdateProfileProvider>(builder: (context, updateProfileProvider, child) {
                    return CustomElevatedBtn(
                      loading: updateProfileProvider.loading,
                      text: "Save",
                      onPressed: () {
                        updateProfileProvider.updateProfile(
                          context: context,
                          email: emailController.text.trim(),
                          location: locationController.text.trim(),
                          gender: genderController.text.trim(),
                          birthDay: updateProfileProvider.birthDayEditingController.text.trim(),
                          name: nameController.text.trim(),
                        );
                      },
                    );
                  },),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
