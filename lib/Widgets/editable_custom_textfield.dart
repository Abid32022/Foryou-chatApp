import 'package:flutter/material.dart';

class EditCustomField extends StatefulWidget {

  // String hintText;
  bool editName;
  TextEditingController controller;

  EditCustomField({super.key,
  required this.controller,this.editName = false});

  @override
  State<EditCustomField> createState() => _EditCustomFieldState();
}
class _EditCustomFieldState extends State<EditCustomField> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: widget.controller,
        style: TextStyle(fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 4,bottom: 20),
            // suffixStyle: ,
            border: UnderlineInputBorder(
                borderSide: BorderSide.none),
            hintStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
