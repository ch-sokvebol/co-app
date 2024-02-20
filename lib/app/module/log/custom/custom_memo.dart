import 'package:flutter/material.dart';

class CustomTextMemo extends StatelessWidget {
  const CustomTextMemo({
    super.key,
    this.title,
    this.ontap,
  });
  final String? title;
  final Function? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap!(),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.transparent,
              padding: EdgeInsets.only(top: 18, left: 20),
              child: Text(
                title ?? "",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 8,
              thickness: 0.8,
            ),
          ],
        ),
      ),
    );
  }
}
