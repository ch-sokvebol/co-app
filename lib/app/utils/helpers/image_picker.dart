import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future onChooseImage(
      {ImageSource? media, String? loanId, File? fileImage}) async {
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: media!);

    if (img != null) {
      fileImage = File(img.path);
      // fileImage = file;
      // uploadImage(file, loanId!).then((imgUrl) {
      //   imagePathFile.value = json.decode(imgUrl)["imageUrl"];
      //   debugPrint('kkiiii:${imagePathFile.value}');
      // });
      debugPrint('heoo:$fileImage');
    }
  }

  // final con = Get.put(LoanArrearController());
  static myAlert({BuildContext? context, File? file, String? loanId}) {
    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      onChooseImage(
                          media: ImageSource.gallery,
                          loanId: loanId,
                          fileImage: file);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      // getImage(ImageSource.camera);
                      onChooseImage(media: ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
