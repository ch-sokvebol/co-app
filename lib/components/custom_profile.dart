import 'package:cached_network_image/cached_network_image.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomProfileUser extends StatelessWidget {
  final double? hight;
  final double? width;
  final GestureTapCallback? ontap;
  final bool isverify;
  final double? hightVerify;
  final double? widthVerify;
  final String? imageUrl;
  const CustomProfileUser({
    Key? key,
    this.hight,
    this.width,
    this.isverify = false,
    this.hightVerify,
    this.widthVerify,
    this.ontap,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: imageUrl == ""
            ? SvgPicture.asset(
                "assets/svg/icon_profile.svg",
                height: 90,
                width: 90,
              )
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                fadeInCurve: Curves.easeIn,
                height: 94,
                width: 94,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      color: logolightGreen, value: downloadProgress.progress),
                ),
              ),
      ),
    );
  }
}
