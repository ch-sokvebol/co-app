import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:flutter/material.dart';

class DetailTitlePolicyScreen extends StatelessWidget {
  const DetailTitlePolicyScreen({
    super.key,
    this.type,
    this.title,
    this.releaseDate,
    this.createDate,
    this.onTab,
  });
  final String? title;
  final String? type;
  final String? releaseDate;
  final String? createDate;
  final GestureTapCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        // padding:
        //     const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Colors.white,
          // border: Border.all(width: 1, color: AppColors.logolightGreen),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "$title",
                    // "Attendance Implementation",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  // width: 30,
                  // height: 30,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // shape: BoxShape.circle,
                      border: Border.all(
                          width: 1, color: AppColors.logolightGreen)),
                  child: Center(
                    child: Text(
                      "$type",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Container(
            //       margin: EdgeInsets.only(top: 5),
            //       height: 8,
            //       width: 8,
            //       decoration: BoxDecoration(
            //         color: Colors.black,
            //         shape: BoxShape.circle,
            //       ),
            //     ),
            //     //  Container(
            //     //   height: 8,
            //     //   width: 8,
            //     //   decoration: BoxDecoration(
            //     //     color: Colors.black,
            //     //     shape: BoxShape.circle,
            //     //   ),
            //     // ),
            //     Container(
            //       padding: EdgeInsets.only(left: 10),
            //       child: Text(
            //         "Create Date",
            //         // "Attendance Implementation",
            //         style: TextStyle(
            //           fontSize: 16,
            //           color: Colors.black,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ),
            //     Spacer(),
            //     Container(
            //       child: Text(
            //         "$createDate",
            //         //  "14-04-2023",
            //         style: TextStyle(
            //           fontSize: 16,
            //           color: Colors.grey,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Container(
            //       margin: EdgeInsets.only(top: 5),
            //       height: 8,
            //       width: 8,
            //       decoration: BoxDecoration(
            //         color: Colors.black,
            //         shape: BoxShape.circle,
            //       ),
            //     ),
            //     //  Container(
            //     //   height: 8,
            //     //   width: 8,
            //     //   decoration: BoxDecoration(
            //     //     color: Colors.black,
            //     //     shape: BoxShape.circle,
            //     //   ),
            //     // ),
            //     // Container(
            //     //   padding: EdgeInsets.only(left: 10),
            //     //   child: Text(
            //     //     "Release Date",
            //     //     // "Attendance Implementation",
            //     //     style: TextStyle(
            //     //       fontSize: 16,
            //     //       color: Colors.black,
            //     //       fontWeight: FontWeight.w600,
            //     //     ),
            //     //   ),
            //     // ),
            //     // Spacer(),
            //     // Container(
            //     //   child: Text(
            //     //     "$releaseDate",
            //     //     //  "14-04-2023",
            //     //     style: TextStyle(
            //     //       fontSize: 16,
            //     //       color: Colors.grey,
            //     //       fontWeight: FontWeight.w600,
            //     //     ),
            //     //   ),
            //     // ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
