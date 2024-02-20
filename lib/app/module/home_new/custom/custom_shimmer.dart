import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.8),
        highlightColor: Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: Colors.grey.withOpacity(0.3),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.55,
                  color: Colors.grey.withOpacity(0.3),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
