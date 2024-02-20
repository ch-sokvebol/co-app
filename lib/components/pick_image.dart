import 'package:chokchey_finance/app/module/log/controller/log_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import 'images.dart';

class CustomUploadImageSell extends StatefulWidget {
  const CustomUploadImageSell({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomUploadImageSell> createState() => _CustomUploadImageSellState();
}

class _CustomUploadImageSellState extends State<CustomUploadImageSell> {
  final controller = Get.put(LogController());
  // Future pickMedia() async {
  //   controller.imageSell = await MultipleImagesPicker.pickImages(
  //     maxImages: 1,
  //     selectedAssets: controller.imageSell,
  //     enableCamera: true,
  //   );
  //   if (!mounted) return;
  //   controller.imageFileSell.value = [];
  //   controller.imageSell.map((e) {
  //     FormatConvert.getImageFileFromAssets(e.).then(
  //       (value) {
  //         controller.imageFileSell.add(value);
  //         controller.update();
  //       },
  //     );
  //   }).toList();
  // }

  bool isImage = false;
  @override
  void initState() {
    setState(() {
      isImage;
      debugPrint("isImage: $isImage");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Container(
        // color: const Color(0xfff5f5f5),

        decoration: BoxDecoration(
            color: const Color(0xfff5f5f5), shape: BoxShape.circle),
        child: GestureDetector(
          onTap: () async {
            isImage = true;
            debugPrint("Image11: $isImage");
            try {
           //   await pickMedia();
              controller.update();
            } catch (e) {
              debugPrint('========$e');
            }
          },
          child: Container(
            width: 100,
            height: 100,
            child: isImage == false
                ? SvgPicture.asset("assets/svg/icon_profile.svg")
                : ImagePickedContainer(
                    onTabDelete: () {},
                    imageFile: controller.imageFileSell[0],
                  ),
          ),
        ),
      ),
    );
  }
}
