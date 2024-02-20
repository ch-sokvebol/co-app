// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:chokchey_finance/app/module/log/controller/log_controller.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import 'images.dart';

class CustomProfileuser extends StatelessWidget {
  CustomProfileuser({super.key});
  final controller = Get.put(LogController());

  // Future pickMedia() async {
  //   controller.imageSell = await MultipleImagesPicker.pickImages(
  //     maxImages: 1,
  //     selectedAssets: controller.imageSell,
  //     enableCamera: true,
  //   );
  //   //if (!mounted) return;
  //   controller.imageFileSell.value = [];
  //   controller.imageSell.map((e) {
  //     //
  //     controller.isImage.value = true;
  //     FormatConvert.getImageFileFromAssets(e).then(
  //       (value) {
  //         controller.imageFileSell.add(value);
  //         controller.update();
  //       },
  //     );
  //   }).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xfff5f5f5),
      padding: const EdgeInsets.only(
        left: 8,
        top: 10,
      ),
      height: 94,
      width: 94,

      child: GestureDetector(
        onTap: () async {},
        child: Obx(
          () => controller.imageFileSell.isEmpty
              ? SvgPicture.asset(
                  "assets/svg/icon_profile.svg",
                  color: logoDarkBlue,
                )
              : ImagePickedContainer(
                  onTabDelete: () {},
                  imageFile: controller.imageFileSell[0],
                ),
        ),
      ),
    );
  }
}
