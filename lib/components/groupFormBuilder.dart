// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GroupFromBuilder extends StatelessWidget {
  final IconData? icons;
  final Key? keys;
  final Widget? childs;
  final AssetImage? imageIcon;
  final Color? colors;
  final ShapeBorder? shapes;
  final Color? imageColor;
  final double? elevations;
  GroupFromBuilder(
      {this.icons,
      this.keys,
      this.childs,
      this.imageIcon,
      this.colors,
      this.shapes,
      this.imageColor,
      this.elevations});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 13),
      decoration: BoxDecoration(
          color: colors ?? Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                blurRadius: 0,
                spreadRadius: 1,
                offset: Offset(0, 0),
                color: Colors.grey.withOpacity(0.2))
          ]),
      //color: colors ?? null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (imageIcon != null)
            Container(
              padding: EdgeInsets.only(left: 12),
              child: Image(
                image: imageIcon!,
                width: 18,
                color: imageColor ?? Colors.grey,
              ),
            ),
          if (imageIcon == null)
            Container(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                icons,
                color: Colors.grey,
              ),
            ),
          FormBuilder(
            key: keys,
            initialValue: {
              'date': DateTime.now(),
              'accept_terms': false,
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 300,
                  child: childs,
                ),
              ],
            ),
          ),
          Text('')
        ],
      ),
    );
  }
}
