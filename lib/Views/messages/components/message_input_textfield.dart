import 'package:chat_app2/model/messages_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors.dart';

class MessageInputTextField extends StatelessWidget {
   void Function()? onPressed;
   bool? loading ;
   TextEditingController messageController = TextEditingController();
   MessageInputTextField({required this.loading,required this.onPressed, required this
       .messageController,super.key});
  @override
  Widget build(BuildContext context) {
    return TextFormField(keyboardType: TextInputType.name,
      controller: messageController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        hintText: 'Write Your Message',
        hintStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w300,
        ),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: loading == true ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator()):Icon(
            Icons.send_sharp,
            color: AppColors.textGreyColor,
          ),
        ),
        fillColor: Color(0xffF3F6F6),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        filled: true,
        border: InputBorder.none,
      ),
    );
  }
}
