import 'package:chat_app2/model/messages_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors.dart';

class MessageInputTextField extends StatefulWidget {
  @override
  State<MessageInputTextField> createState() => _MessageInputTextFieldState();
}

class _MessageInputTextFieldState extends State<MessageInputTextField> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _messageController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        hintText: 'Write Your Message',
        hintStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w300,
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(
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