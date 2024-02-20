import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/app_color.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String? title;
  final GestureTapCallback? onPressed;
  final bool? isDisable;
  final bool? isOutline;
  final String? iconUrl;
  final bool? isHaveColor;
  final IconData? icon;
  TextStyle? textStyle;
  Color? color;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  CustomButton(
      {this.title,
      this.isHaveColor = false,
      this.onPressed,
      this.isDisable = false,
      this.icon,
      this.isOutline = false,
      this.iconUrl,
      this.color,
      this.textStyle});
  @override
  Widget build(BuildContext context) {
    return !isDisable! && !isOutline!
        ? GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: isHaveColor == true
                        ? AppColor.primaryColor
                        : Colors.white),
                borderRadius: BorderRadius.circular(6),
                color: color ?? AppColor.primaryColor,
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  iconUrl != null ? Icon(icon) : Container(),
                  if (iconUrl != null)
                    const SizedBox(
                      width: 10,
                    ),
                  Text(
                    title!,
                    style: textStyle ??
                        Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          )
        : isOutline! && !isDisable!
            ? SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: AppColor.subTextColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        iconUrl != null ? Icon(icon) : Container(),
                        if (iconUrl != null)
                          const SizedBox(
                            width: 15,
                          ),
                        Text(
                          title!,
                          style: textStyle ??
                              Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      color: AppColor.subTextColor,
                                      fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  padding: const EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 16.0, bottom: 16.0),
                  color: AppColor.primaryColor,
                  disabledColor: const Color(0xffF5F5F5),
                  onPressed: null,
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: textStyle ??
                        Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: const Color(0xffC2C2C2),
                            fontWeight: FontWeight.w600),
                  ),
                ),
              );
  }
}
