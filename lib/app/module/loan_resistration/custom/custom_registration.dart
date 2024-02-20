import 'package:chokchey_finance/app/module/config/app_color.dart';
import 'package:flutter/material.dart';

class CustomLoadRegistration extends StatelessWidget {
  const CustomLoadRegistration(
      {super.key,
      this.isTextCenter = false,
      this.colorFont,
      this.size,
      this.title,
      this.subTitleStyle,
      this.subtitle,
      this.onTap,
      this.isSubtitle = false,
      this.icon,
      this.iconTrainding,
      this.isTrailingIcon = false,
      this.textStyle});
  final bool? isTextCenter;
  final Color? colorFont;
  final double? size;
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final IconData? iconTrainding;
  final bool? isTrailingIcon;
  final bool? isSubtitle;
  final TextStyle? textStyle;
  final TextStyle? subTitleStyle;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap!(),
      child: Container(
        height: 60,
        padding: EdgeInsets.only(left: 16, right: 16),
        margin: EdgeInsets.only(
          top: 13,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 0,
              spreadRadius: 1,
              offset: Offset(0, 0),
              color: Colors.grey.withOpacity(0.2),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: isTextCenter == true
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColor.primaryColor,
              // color: Color(0xff505050),
              size: 26,
            ),
            SizedBox(
              width: isTextCenter == true ? 0 : 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$title",
                    style: textStyle ??
                        TextStyle(
                          fontSize: 16,
                          color: Color(0xff505050),
                        )),
                isSubtitle == true
                    ? Text(
                        "$subtitle",
                        style: subTitleStyle,
                      )
                    : SizedBox(),
              ],
            ),
            isTextCenter == true ? SizedBox() : Spacer(),
            isTrailingIcon == true
                ? Icon(
                    iconTrainding ?? Icons.cancel,
                    color: Color(0xff505050),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
