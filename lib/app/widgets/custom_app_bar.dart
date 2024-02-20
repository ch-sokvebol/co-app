// ignore: non_constant_identifier_names

import 'dart:io';

import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:flutter/material.dart';

CustomAppBar(
    {required BuildContext context,
    Widget? leading,
    List<Widget>? action,
    required String? title,
    Widget? iconBack,
    double? elevation,
    Color? backgroundColor,
    bool? isLogo = true,
    bool? isCallonPressed = false,
    VoidCallback? onPressed,
    bool? centerTitle = false,
    GestureTapCallback? onTap}) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    centerTitle: centerTitle,
    automaticallyImplyLeading: false,
    // ignore: deprecated_member_use
    // brightness: Get.theme.brightness == Brightness.dark
    //     ? Brightness.light
    //     : Brightness.dark,
    elevation: elevation ?? 1.0,
    actions: action,
    backgroundColor: backgroundColor ?? AppColors.logolightGreen,

    title: Text(
      '$title',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
    ),
    leading: leading ??
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Platform.isIOS
                ? Icon(Icons.arrow_back_ios)
                : Icon(Icons.arrow_back)),
  );
}
