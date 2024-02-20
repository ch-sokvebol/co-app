import 'dart:convert';
import 'dart:io';

import 'package:chokchey_finance/app/module/loan_arrear/controllers/loan_arrear_controller.dart';
import 'package:chokchey_finance/app/module/util/widget/custom_textfield.dart';
import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:chokchey_finance/app/utils/helpers/dropdow_item.dart';
import 'package:chokchey_finance/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../utils/helpers/custom_drop_down.dart';
import '../../../utils/helpers/map_helper.dart';
import '../../util/widget/custom_button.dart';

class LoanFollowUpScreen extends StatefulWidget {
  final String? loanId;
  final String? village;
  final String? commune;
  final String? district;
  final String? province;
  final String? customerCodes;
  final String? customerNames;
  final String? loanNumber;
  final double? loanAmount;
  final double? overdueDay;
  final String? coName;
  final String? coId;
  final String? status;
  final String? brancCode;
  final String? brancName;
  final String? repaymentDate;
  final double? loanPeriod;
  final String? createdDate;
  final String? createdBy;
  LoanFollowUpScreen({
    super.key,
    this.loanId,
    this.village,
    this.commune,
    this.district,
    this.province,
    this.customerCodes,
    this.customerNames,
    this.loanNumber,
    this.loanAmount,
    this.overdueDay,
    this.coName,
    this.coId,
    this.status,
    this.brancCode,
    this.brancName,
    this.repaymentDate,
    this.loanPeriod,
    this.createdDate,
    this.createdBy,
  });

  @override
  State<LoanFollowUpScreen> createState() => _LoanFollowUpScreenState();
}

class _LoanFollowUpScreenState extends State<LoanFollowUpScreen> {
  File imageFile = File('imagePath');
  final ImagePicker picker = ImagePicker();
  final con = Get.put(LoanArrearController());
  final mapCon = Get.put(MapHelperController());

  // XFile? image;

  // Future getImage(ImageSource media) async {
  //   final img = await picker.pickImage(source: media);

  //   setState(() {
  //     con.image = img;
  //   });
  // }

  void myAlert({BuildContext? context, File? img}) {
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
                      // getImages();
                      con.onChooseImage(
                          media: ImageSource.gallery, fileimg: img);
                      // con.pickImg1(
                      //     context: context,
                      //     imageSource: ImageSource.gallery,
                      //     files: con.imageFile.value);
                      con.update();
                      setState(() {});
                      // setState(() {
                      //   ImagePickerHelper.onChooseImage(
                      //       media: ImageSource.gallery,
                      //       fileImage: con.imageFile.value);
                      // });
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
                      con.onChooseImage(media: ImageSource.camera);
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

  onValidate() {
    if (con.txtDescription.value == '') {
      con.isDescription.value = true;
    } else {
      con.isDescription.value = false;
    }
    if (con.txtTitle.value == '') {
      con.isoccu.value = true;
    } else {
      con.isoccu.value = false;
    }
    if (con.txtCompanyName.value == '') {
      con.isCompany.value = true;
    } else {
      con.isCompany.value = false;
    }
    if (con.imageFile.value.path == '') {
      con.isImage.value = true;
    } else {
      con.isImage.value = false;
    }
    if (con.txtDescription.value != '' &&
        con.txtTitle.value != '' &&
        con.txtCompanyName.value != '' &&
        con.imageFile.value.path != '') {
      con.uploadImage(con.imageFile.value, widget.loanId!).then((imgUrl) {
        con.imagePathFile.value = json.decode(imgUrl)["imageUrl"];
        con
            .onArrFollowUp(
          context: context,
          latitude: mapCon.latitute,
          longitude: mapCon.longtitute,
          village: widget.village,
          commune: widget.commune,
          district: widget.district,
          province: widget.province,
          customerCode: widget.customerCodes,
          customerName: widget.customerNames,
          loanNumber: widget.loanNumber,
          loanAmount: widget.loanAmount,
          overdueDay: widget.overdueDay,
          coName: widget.coName,
          coId: widget.coId,
          brancCode: widget.brancCode,
          brancName: widget.brancName,
          repaymentDate: widget.repaymentDate,
          loanPeriod: widget.loanPeriod,
        )
            .then((value) {
          con.onClearArrFollow();
        });
      });
    }
  }

  @override
  void initState() {
    mapCon.onAdd();
    con.getOption();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return CupertinoScaffold(
      body: Builder(builder: (context) {
        return Scaffold(
          appBar: CustomAppBar(
            context: context,
            title: "Loan Arrear Follow Up",
            centerTitle: true,
          ),
          body: Obx(
            () => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: CustomTextFieldNew(
                    hintText: 'Description *',
                    onChange: (r) {
                      if (r != '') {
                        con.txtDescription.value = r;
                        con.isDescription.value = false;
                      } else {
                        con.txtDescription.value = '';
                        con.isDescription.value = true;
                      }
                    },
                    isValidate: con.isDescription.value,
                    // labelText: 'Input Reason',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CustomDropDown(
                    label: 'Occupation',
                    labelColor: AppColors.logoDarkBlue.withOpacity(0.7),
                    borderColor: AppColors.logoDarkBlue,
                    borderWith: 1.8,
                    item: [
                      ...con.allOptionModel.value.clientCommitment!
                          .asMap()
                          .entries
                          .map((e) {
                        return DropDownItem(
                          itemList: {
                            "Name": "${e.value}",
                            // "Code": "${e.value.id}",
                          },
                        );
                      })
                    ],
                    onChange: (e) {
                      if (e != '') {
                        con.txtTitle.value = e['Name'];
                        con.txtTitleSub.value = e['Code'];
                        con.isoccu.value = false;
                      } else {
                        con.txtTitle.value = e[''];
                        con.txtTitleSub.value = e[''];
                        con.isoccu.value = true;
                      }
                    },
                    defaultValue: con.txtTitle.value != ''
                        ? {"Name": con.txtTitle.value}
                        : null,
                    isValidate: con.isoccu.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: CustomTextFieldNew(
                    hintText: 'Company Name *',
                    onChange: (r) {
                      if (r != '') {
                        con.txtCompanyName.value = r;
                        con.isCompany.value = false;
                      } else {
                        con.txtCompanyName.value = '';
                        con.isCompany.value = true;
                      }
                    },
                    isValidate: con.isCompany.value,
                    // labelText: 'Input Reason',
                  ),
                ),
                // CustomDropDownNews(
                //   label: 'Test',
                //   // title: con.searchModel.value.uname,
                //   child: ListView.builder(
                //       shrinkWrap: true,
                //       itemCount: con.searchList.length,
                //       itemBuilder: (context, index) {
                //         return Text('${con.searchList[index].uname}');
                //       }),
                // ),
                con.imageFile.value.path != ''
                    ? Container(
                        width: 180,
                        height: 180,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  //to show image, you type like this.
                                  // File(imgpath!.path),
                                  File(con.imageFile.value.path),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                  onPressed: () {
                                    con.imageFile.value = File('');
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.black87,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          myAlert(context: context);
                          // ImagePickerHelper.myAlert(
                          //     file: con.imageFile.value, context: context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 30, right: 20),
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black12,
                              border: Border.all(
                                  color: con.isImage.value == true
                                      ? Colors.red
                                      : Colors.black12)),
                          child: Center(
                            child: Image.asset(
                              'assets/images/cornerCa.png',
                              width: 100,
                              height: 100,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                // con.imgFile2.value.path != ''
                //     ? imageContainer(imgpath: con.imgFile2.value)
                //     : defualtImage(),
                // Text('lat: ${mapCon.latitute}-long: ${mapCon.longtitute}'),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 40, top: 40),
                  child: con.isLoadingArrUp.value == true
                      ? Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.logoDarkBlue,
                          ),
                          width: double.infinity,
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 25,
                          ),
                        )
                      : CustomButton(
                          title: 'Submit',
                          textStyle: theme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          color: AppColors.logoDarkBlue,
                          onPressed: () {
                            onValidate();
                            // debugPrint('lll:${con.imageFile.value}');

                            // con.uploadImage(con.imageFile.value);
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget imageContainer({
    File? imgpath,
  }) {
    return Container(
      width: 180,
      height: 180,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                //to show image, you type like this.
                File(imgpath!.path),
                // File(con.imageFile.value.path),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 300,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
                onPressed: () {
                  // con.onDeleteImage(imgpath!);
                  imgpath = File('');
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.black87,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  // Widget defualtImage({File? file}) {
  //   return GestureDetector(
  //     onTap: () {
  //       myAlert(context: context, img: file);
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(top: 30, right: 20),
  //       width: 160,
  //       height: 160,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           color: Colors.black12,
  //           border: Border.all(
  //               color:
  //                   con.isImage.value == true ? Colors.red : Colors.black12)),
  //       child: Center(
  //         child: Image.asset(
  //           'assets/images/cornerCa.png',
  //           width: 100,
  //           height: 100,
  //           color: Colors.grey,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  List<File> selectedImages = [];

  // final pickimg = ImagePicker();
  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
