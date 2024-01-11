import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class SelectGender extends StatefulWidget {
  String labelText;
  String? Function(String?)? validator;
  TextEditingController? genderController;
  // VoidCallback? onTap;
  void Function(String)? onSelected;

  SelectGender({required this.validator,required this.labelText,this.onSelected , this.genderController});

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  List<String> items = ['Male', 'Female', 'Others'];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:widget.validator,
      controller: widget.genderController,
      // onTap: ,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textFieldTextColor,
          letterSpacing: 0.1,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        suffixIcon: PopupMenuButton<String>(
          icon: Icon(
            Icons.arrow_drop_down_sharp,
            size: 50,
          ),
          onSelected: widget.onSelected,
          itemBuilder: (BuildContext context) {
            return items.map<PopupMenuItem<String>>(
              (String value) {
                return PopupMenuItem(
                  child: Text(value),
                  value: value,
                );
              },
            ).toList();
          },
        ),
      ),
    );
  }
}
