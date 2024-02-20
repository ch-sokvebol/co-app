// ignore_for_file: must_be_immutable

import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';

class ImagePickers extends StatelessWidget {
  dynamic onPressed;
  IconData? icon;
  String? heroTag;
  var sizeIcons;
  var widths;
  var heights;

  ImagePickers(
      {this.onPressed,
      this.icon,
      this.heroTag,
      this.sizeIcons,
      this.heights,
      this.widths});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            width: widths,
            height: heights,
            child: FloatingActionButton(
              heroTag: heroTag,
              onPressed: onPressed ? onPressed : null,
              backgroundColor: logolightGreen,
              tooltip: 'Pick Image',
              child: Icon(
                icon,
                size: sizeIcons,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
