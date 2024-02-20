import 'dart:io';

import 'package:flutter/material.dart';

class ImagePickedContainer extends StatelessWidget {
  const ImagePickedContainer({
    Key? key,
    required this.imageFile,
    required this.onTabDelete,
    // required this.index,
  }) : super(key: key);

  final File imageFile;
  final Function onTabDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage(imageFile.path), fit: BoxFit.cover),
      ),
    );
  }
}
