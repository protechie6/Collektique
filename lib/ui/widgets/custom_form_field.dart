import 'package:flutter/material.dart';
import '../../utils/all_constants.dart';
import 'text.dart';

class CustomFormField extends StatelessWidget {
  final bool isPassword;
  final TextEditingController controller;
  final bool isEmail;
  final String? hint;
  final bool isEnable;
  final double fontSize;
  final Color? hintColor;
  final String? Function(String?)? validator;

  const CustomFormField(
      {Key? key,
      required this.controller,
      this.isPassword = false,
      this.isEmail = false,
      this.hint,
      this.isEnable = true,
      this.fontSize = 15.0,
      this.hintColor = AppColors.white,
      this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: isEnable,
        controller: controller,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        style: textStyle(fontSize: fontSize),
        decoration: InputDecoration(
            labelText: hint,
            labelStyle: textStyle(fontSize: 20.0, color: hintColor,),
            enabledBorder: const UnderlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: AppColors.white),
          ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            ),
            validator: validator,
        obscureText: isPassword,
    );
  }
}
