import 'dart:io';

import 'package:chokchey_finance/app/module/log/controller/log_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


Future<dynamic> pickImage(
  BuildContext context,
) {
  final controller = Get.put(LogController());
  final lastIndex = controller.image.value.lastIndexOf(RegExp(r'.jp'));
  return Platform.isIOS
      ? showCupertinoModalPopup(
          context: context,
          builder: (_) {
            return Builder(
              builder: (context) {
                return CupertinoActionSheet(
                  actions: [
                    Container(
                      color: Colors.white,
                      child: CupertinoActionSheetAction(
                        onPressed: () async {
                          Navigator.pop(context);
                          XFile? pickedFile = await ImagePicker().pickImage(
                            source: ImageSource.camera,
                          );
                          if (pickedFile != null) {
                            controller.imageProfile = File(pickedFile.path);

                            // final splitted = controller.image.value
                            //     .substring(0, (lastIndex));
                            // final outPath =
                            //     "${splitted}_out${controller.image.value.substring(lastIndex)}";
                            // var result =
                            //     await FlutterImageCompress.compressAndGetFile(
                            //   controller.image.value,
                            //   outPath,
                            //   quality: 50,
                            // );
                            controller.image.value =
                                controller.imageProfile!.path;
                            controller.image.value = lastIndex.toString();
                            // controller.imageSell.map((e) {
                            //   FormatConvert.getImageFileFromAssets(e).then(
                            //     (value) {
                            //       controller.imageFileSell.add(value);
                            //       controller.imageProfile = value;
                            //       controller.update();
                            //     },
                            //   );
                            // }).toList();
                            // getIt<UserController>().postChangeProfilePhoto(
                            //     profile:
                            //         controller.imageProfile!.path);
                          }
                        },
                        child: const Text('Take Photo'),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: CupertinoActionSheetAction(
                        onPressed: () async {
                          Navigator.pop(context);
                          XFile? pickedFile = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );
                          if (pickedFile != null) {
                            controller.imageProfile = File(pickedFile.path);
                            controller.image.value =
                                controller.imageProfile!.path;
                            controller.image.value = lastIndex.toString();
                            // controller.imageSell.map((e) {
                            //   FormatConvert.getImageFileFromAssets(e).then(
                            //     (value) {
                            //       controller.imageFileSell.add(value);
                            //       controller.imageProfile = value;
                            //       controller.update();
                            //     },
                            //   );
                            // }).toList();
                            // getIt<UserController>().postChangeProfilePhoto(
                            //     profile:
                            //         getIt<UserController>().imageProfile!.path);
                          }
                        },
                        child: const Text('Choose From Library'),
                      ),
                    ),
                    // if (getIt<UserController>().userModel.value.profile != null)
                    //   Container(
                    //     color: Colors.white,
                    //     child: CupertinoActionSheetAction(
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => ViewPhotoPage(
                    //               singleImage: getIt<UserController>()
                    //                   .userModel
                    //                   .value
                    //                   .profile,
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //       child: const Text('View Photo'),
                    //     ),
                    //   ),
                    // if (getIt<UserController>().userModel.value.profile != null)
                    Container(
                      color: Colors.white,
                      child: CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                          //  getIt<UserController>().removeProfile();
                        },
                        isDestructiveAction: true,
                        child: const Text('Remove Photo'),
                      ),
                    ),
                  ],
                  cancelButton: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CupertinoActionSheetAction(
                      onPressed: () {},
                      child: const Text('Cancel'),
                    ),
                  ),
                );
              },
            );
          },
        )
      : showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (_) {
            return GetBuilder(
              init: controller,
              builder: (_) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          XFile? pickedFile = await ImagePicker().pickImage(
                            source: ImageSource.camera,
                          );
                          if (pickedFile != null) {
                            controller.imageProfile = File(pickedFile.path);
                            controller.image.value =
                                controller.imageProfile!.path;
                            controller.image.value = lastIndex.toString();
                            // getIt<UserController>().postChangeProfilePhoto(
                            //     profile:
                            //         getIt<UserController>().imageProfile!.path);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          color: Colors.transparent,
                          child: Text('Take Photo',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.blue)),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          XFile? pickedFile = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );
                          if (pickedFile != null) {
                            controller.imageProfile = File(pickedFile.path);
                            controller.image.value =
                                controller.imageProfile!.path;
                            controller.image.value = lastIndex.toString();
                            // getIt<UserController>().postChangeProfilePhoto(
                            //     profile:
                            //         getIt<UserController>().imageProfile!.path);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          color: Colors.transparent,
                          child: Text('Choose From Library',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.blue)),
                        ),
                      ),
                      // if (getIt<UserController>().userModel.value.profile !=
                      //     null)
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ViewPhotoPage(
                          //       singleImage: getIt<UserController>()
                          //           .userModel
                          //           .value
                          //           .profile,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          color: Colors.transparent,
                          child: Text('View Photo',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.blue)),
                        ),
                      ),
                      // if (getIt<UserController>().userModel.value.profile !=
                      //     null)
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // getIt<UserController>().removeProfile();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          color: Colors.transparent,
                          child: Text('Remove Photo',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.blue)),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          color: Colors.transparent,
                          child: Text('Cancel',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
}
