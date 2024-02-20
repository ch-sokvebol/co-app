import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';

class CustomCardPolicy extends StatelessWidget {
  const CustomCardPolicy({
    super.key,
    this.icon,
    this.onTap,
    this.text,
  });
  final IconData? icon;
  final String? text;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap!(),
      child: Container(
        height: 70,
        padding: EdgeInsets.only(
          left: 16,
          right: 10,
        ),
        margin: EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: logolightGreen,
          ),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: onTap!(),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: logolightGreen,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.note,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              "$text",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
