import 'package:flutter/material.dart';

class CustomStatusLMap extends StatelessWidget {
  const CustomStatusLMap({super.key, this.color, this.title});
  final Color? color;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 6, top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                width: .7,
                color: Colors.grey.withOpacity(0.6),
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            "${title ?? ""}",
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
