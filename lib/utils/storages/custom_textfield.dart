import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintText,
    this.labelText,
  });
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? hintText;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        // autofocus: true,
        controller: controller,
        maxLength: 6,
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        onFieldSubmitted: onFieldSubmitted,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: logolightGreen),
          ),
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(
            fontSize: 15,
            color: const Color(0xff0ABAB5),
          ),
        ),
      ),
    );
  }
}
