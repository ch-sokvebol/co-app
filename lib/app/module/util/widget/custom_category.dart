import 'package:flutter/material.dart';

import '../../../../utils/storages/colors.dart';

class CustomCategory extends StatelessWidget {
  const CustomCategory({
    super.key,
    this.title,
    this.ontap,
    this.icon,
  });
  final String? title;

  final Function? ontap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap!(),
      child: Container(
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   border: Border.all(
        //     width: 1,
        //     color: Colors.grey.withOpacity(0.1),
        //   ),
        // ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // SvgPicture.asset(
            //   "$svg",
            //   height: 46,
            // ),
            Icon(
              icon,
              size: 46,
              color: logoDarkBlue,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              title!,
              style: TextStyle(
                fontSize: 18,
                color: logoDarkBlue,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
