import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextfile extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? label;
  final String? hintText;
  final int? maxLine;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool? obscureText;
  final Widget? suffixIcon;

  const CustomTextfile(
      {super.key,
      this.controller,
      this.onChanged,
      this.hintText,
      this.onFieldSubmitted,
      this.label,
      this.maxLine,
      this.focusNode,
      this.obscureText = false,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // autofocus: true,
      controller: controller,
      maxLength: maxLine,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      onFieldSubmitted: onFieldSubmitted,
      // inputFormatters: <TextInputFormatter>[
      //   FilteringTextInputFormatter.digitsOnly
      // ],
      obscureText: obscureText!,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.logolightGreen),
        ),
        suffixIcon: suffixIcon,
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(
          fontSize: 15,
          color: const Color(0xff0ABAB5),
        ),
      ),
      focusNode: focusNode,
    );
  }
}
