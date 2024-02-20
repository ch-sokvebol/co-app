import 'dart:io';

import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

//
ThemeData theme(String local) {
  return ThemeData.light().copyWith(
    primaryColor: AppColor.primaryColor,
    secondaryHeaderColor: AppColor.secondaryColor,
    disabledColor: AppColor.disableColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColor.textColor,
      ),
      elevation: 1.5,
      shadowColor: Colors.white30,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 28,
        fontWeight: FontWeight.normal,
        color: AppColor.textColor,
      ),
      displayMedium: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 28,
        fontWeight: FontWeight.normal,
        color: AppColor.textColor,
      ),
      displaySmall: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColor.textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColor.textColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColor.textColor,
      ),
      titleLarge: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColor.textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColor.subTextColor,
      ),
      titleSmall: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColor.subTextColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: const Color(0xff000000),
      ),
      labelLarge: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 14,
        fontWeight: FontWeight.bold,
        //color: AppColor.buttonColor,
      ),
      labelMedium: TextStyle(
        fontFamily: local.toLowerCase() == 'khm'
            ? 'nokora_regular'
            : Platform.isAndroid
                ? 'roboto_regular'
                : Platform.isAndroid
                    ? 'roboto_regular'
                    : 'sf_pro_display',
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.logoDarkBlue,
      ),
    ),
    colorScheme: ColorScheme(
      primary: AppColor.primaryColor,
      onPrimary: AppColor.primaryColor,
      background: const Color(0xfffbfbfb),
      onBackground: Colors.black,
      secondary: AppColor.secondaryColor,
      onSecondary: AppColor.secondaryColor,
      error: Colors.black,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      brightness: Brightness.dark,
    ),
  );
}
