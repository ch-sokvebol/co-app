import 'dart:convert';
import 'dart:io';

import 'package:chokchey_finance/app/utils/helpers/custom_drop_down.dart';
import 'package:chokchey_finance/localizations/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../utils/colors/app_color.dart';
import '../../../utils/helpers/activity_log.dart';
import '../../../utils/helpers/custom_datepicker.dart';
import '../../../utils/helpers/dropdow_item.dart';
import '../../../utils/helpers/map_helper.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../util/widget/custom_button.dart';
import '../../util/widget/custom_textfield.dart';
import '../controllers/loan_arrear_controller.dart';

class ArrearFollowUpNew extends StatefulWidget {
  final String? loanId;
  final String? village;
  final String? commune;
  final String? district;
  final String? province;
  final String? customerCodes;
  final String? customerNames;
  final String? loanNumber;
  final num? loanAmount;
  final num? overdueDay;
  final String? coName;
  final String? coId;
  final String? status;
  final String? brancCode;
  final String? brancName;
  final String? repaymentDate;
  final num? loanPeriod;
  final String? createdDate;
  final String? createdBy;
  final num? overdueAmt, loanBalance;
  final String? workPlace;
  final String? jobName;
  final String? type;
  final String? currencyCode;
  const ArrearFollowUpNew(
      {super.key,
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
      this.overdueAmt,
      this.workPlace,
      this.jobName,
      this.type,
      this.currencyCode,
      this.loanBalance});

  @override
  State<ArrearFollowUpNew> createState() => _ArrearFollowUpNewState();
}

class _ArrearFollowUpNewState extends State<ArrearFollowUpNew> {
  final con = Get.put(LoanArrearController());
  final mapCon = Get.put(MapHelperController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return CupertinoScaffold(
      body: Builder(builder: (context) {
        return Scaffold(
          appBar: CustomAppBar(
            context: context,
            title: AppLocalizations.of(context)!
                .translate('loan_arrear_follow_up'),
            centerTitle: true,
          ),
          body: Obx(
            () => Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomDropDown(
                              label: 'Reasons of overdue',
                              labelColor:
                                  AppColors.logoDarkBlue.withOpacity(0.7),
                              borderColor: AppColors.logoDarkBlue,
                              borderWith: 1.8,
                              item: [
                                ...con.allOptionModel.value.reasonsOfOverdue!
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  return DropDownItem(
                                    itemList: {
                                      "Name": "${e.value.display}",
                                    },
                                  );
                                }).toList()
                              ],
                              onChange: (e) {
                                if (e != '') {
                                  con.txtReasonNew.value = e['Name'];
                                  con.txtJobName.value = '';
                                  con.txtWorkplace.value = '';
                                  con.isReasonNew.value = false;
                                } else {
                                  con.txtReasonNew.value = e[''];

                                  con.isReasonNew.value = true;
                                }
                              },
                              defaultValue: con.txtReasonNew.value != ''
                                  ? {
                                      "Name": con.txtReasonNew.value,
                                    }
                                  : null,
                              isValidate: con.isReasonNew.value,
                            ),
                          ),
                          if (con.txtReasonNew.value == 'Fail in business' ||
                              con.txtReasonNew.value == 'Lost job')
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: CustomTextFieldNew(
                                    hintText: 'Job/Business status',
                                    isValidate: con.isJobName.value,
                                    onChange: (value) {
                                      if (value != '') {
                                        con.txtJobName.value = value;
                                        con.isJobName.value = false;
                                      } else {
                                        con.txtJobName.value = '';
                                        con.isJobName.value = true;
                                      }
                                    },
                                    labelText: 'Job/Business status',
                                    hinTextColor:
                                        AppColors.logoDarkBlue.withOpacity(0.7),
                                    labelColor:
                                        AppColors.logoDarkBlue.withOpacity(0.7),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: CustomTextFieldNew(
                                    hintText: 'Workplace/Business',
                                    isValidate: con.isWorkPlace.value,
                                    onChange: (value) {
                                      if (value != '') {
                                        con.txtWorkplace.value = value;
                                        con.isWorkPlace.value = false;
                                      } else {
                                        con.txtWorkplace.value = '';
                                        con.isWorkPlace.value = true;
                                      }
                                    },
                                    labelText: 'Workplace/Business',
                                    hinTextColor:
                                        AppColors.logoDarkBlue.withOpacity(0.6),
                                    labelColor:
                                        AppColors.logoDarkBlue.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomDropDown(
                              label: 'Solving status',
                              labelColor:
                                  AppColors.logoDarkBlue.withOpacity(0.7),
                              borderColor: AppColors.logoDarkBlue,
                              borderWith: 1.8,
                              item: [
                                ...con.allOptionModel.value.solvingStatus!
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  return DropDownItem(
                                    itemList: {
                                      "Name": "${e.value.display}",
                                    },
                                  );
                                }).toList()
                              ],
                              onChange: (e) {
                                if (e != '') {
                                  con.txtSolvingNew.value = e['Name'];
                                  con.isSolvingNew.value = false;
                                } else {
                                  con.txtSolvingNew.value = e[''];

                                  con.isSolvingNew.value = true;
                                }
                              },
                              defaultValue: con.txtSolvingNew.value != ''
                                  ? {
                                      "Name": con.txtSolvingNew.value,
                                    }
                                  : null,
                              isValidate: con.isSolvingNew.value,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomDropDown(
                              label: 'Client commitment',
                              labelColor:
                                  AppColors.logoDarkBlue.withOpacity(0.7),
                              borderColor: AppColors.logoDarkBlue,
                              borderWith: 1.8,
                              item: [
                                ...con.allOptionModel.value.clientCommitment!
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  return DropDownItem(
                                    itemList: {
                                      "Name": "${e.value.display}",
                                      // "Code": "${e.value.id}",
                                    },
                                  );
                                }).toList()
                              ],
                              onChange: (e) {
                                if (e != '') {
                                  con.txtClientComNew.value = e['Name'];
                                  /////clear when select other
                                  // con.txtPayFullAmt.value = 0;
                                  con.txtPayFullDate.text = '';
                                  con.txtRevolvingDate.text = '';
                                  con.txtDisburseDate.text = '';
                                  con.txtStatusPayAmt.value = 0.0;
                                  con.txtStatusPayDate.text = '';
                                  con.fullAmt.text = '';

                                  // con.txtClientCom.value = e['Code'];
                                  con.isClientComNew.value = false;
                                } else {
                                  con.txtClientComNew.value = e[''];
                                  // con.txtTitleSub.value = e[''];
                                  con.isClientComNew.value = true;
                                }
                              },
                              defaultValue: con.txtClientComNew.value != ''
                                  ? {
                                      "Name": con.txtClientComNew.value,
                                    }
                                  : null,
                              isValidate: con.isClientComNew.value,
                            ),
                          ),

                          /////////////////////////1
                          if (con.txtClientComNew.value.toLowerCase() !=
                                  'Promise to pay'.toLowerCase() &&
                              con.txtClientComNew.value != '' &&
                              con.txtClientComNew.value.toLowerCase() !=
                                  'Client agreed to do revolving loan'
                                      .toLowerCase() &&
                              con.txtClientComNew.value.toLowerCase() !=
                                  'Client agrees to sell collateral'
                                      .toLowerCase())
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: CustomDatePicker(
                                    controller: con.txtPayFullDate,
                                    hinText: 'Pay Date *',
                                    isValidate: con.isPayFullDate.value,
                                    labelText: 'Pay date *',
                                  ),
                                ),
                                // if (con.txtClientCom.value != 'Promise to pay' &&
                                //     con.txtClientCom.value != '')
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: CustomTextFieldNew(
                                    keyboardType: TextInputType.number,
                                    hintText: 'Pay Amount *',
                                    labelText: 'Pay Amount *',
                                    controller: con.fullAmt,
                                    onChange: (e) {
                                      if (e != '') {
                                        con.txtPayFullAmt.value = double.parse(
                                            e.replaceAll(
                                                RegExp(r'[^0-9.]'), ''));
                                        con.isPayFullAmt.value = false;
                                      } else {
                                        con.txtPayFullAmt.value = 0.0;
                                        con.isPayFullAmt.value = true;
                                      }
                                    },
                                    isValidate: con.isPayFullAmt.value,
                                  ),
                                ),
                              ],
                            ),
                          ////////////////////////
                          if (con.txtClientComNew.value ==
                                  'Client agreed to do revolving loan' &&
                              con.txtClientComNew.value != '')
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: CustomDatePicker(
                                    controller: con.txtRevolvingDate,
                                    hinText: 'Do revolving loan date *',
                                    isValidate: con.isRevolvingDate.value,
                                    labelText: 'Do revolving loan date *',
                                  ),
                                ),
                                // if (con.txtClientCom.value != 'Promise to pay' &&
                                //     con.txtClientCom.value != '')
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: CustomDatePicker(
                                    controller: con.txtDisburseDate,
                                    hinText: 'Disbursement Date *',
                                    isValidate: con.isDisburseDate.value,
                                    labelText: 'Disbursement Date *',
                                  ),
                                ),
                              ],
                            ),
                          ///////// client aggree
                          if (con.txtClientComNew.value ==
                                  'Client agrees to sell collateral' &&
                              con.txtClientComNew.value != '')
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: CustomDatePicker(
                                    isValidate: con.isCollateralDate.value,
                                    controller: con.txtColllateralDate,
                                    hinText: 'Sell Date *',
                                    labelText: 'Sell Date *',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: CustomTextFieldNew(
                                    labelText: 'Sell Amount *',
                                    keyboardType: TextInputType.number,
                                    isValidate: con.isCollateralSellAmt.value,
                                    hintText: 'Sell Amount *',
                                    onChange: (e) {
                                      if (e != '') {
                                        con.txtCollateralSellAmt.value =
                                            double.parse(e.replaceAll(
                                                RegExp(r'[^0-9.]'), ''));
                                        con.isCollateralSellAmt.value = false;
                                      } else {
                                        con.txtCollateralSellAmt.value = 0.0;
                                        con.isCollateralSellAmt.value = true;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomDropDown(
                              label: 'Status',
                              labelColor:
                                  AppColors.logoDarkBlue.withOpacity(0.7),
                              borderColor: AppColors.logoDarkBlue,
                              borderWith: 1.8,
                              item: [
                                ...con.allOptionModel.value.status!
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  return DropDownItem(
                                    itemList: {
                                      "Name": "${e.value.display}",
                                      // "Code": "${e.value.id}",
                                    },
                                  );
                                }).toList()
                              ],
                              onChange: (e) {
                                if (e != '') {
                                  con.txtStatusNew.value = e["Name"];

                                  //// clear when select other
                                  con.txtStatusPayAmt.value = 0.0;
                                  con.txtStatusPayDate.text = '';
                                  con.isStatusNew.value = false;
                                  /////
                                } else {
                                  con.txtStatusNew.value = e[""];
                                  con.isStatusNew.value = true;
                                }
                              },
                              defaultValue: con.txtStatusNew.value != ''
                                  ? {
                                      "Name": con.txtStatusNew.value,
                                    }
                                  : null,
                              isValidate: con.isStatusNew.value,
                            ),
                          ),
                          if (con.txtStatusNew.value != '' &&
                              con.txtStatusNew.value ==
                                  'Completed for partial amount')
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: CustomDatePicker(
                                    controller: con.txtStatusPayDate,
                                    hinText: 'Pay Date *',
                                    isValidate: con.isStatusPayDate.value,
                                    labelText: 'Pay Date *',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: CustomTextFieldNew(
                                    labelText: 'Pay Amount *',
                                    keyboardType: TextInputType.number,
                                    isValidate: con.isStatusPayAmt.value,
                                    hintText: 'Pay Amount *',
                                    onChange: (e) {
                                      if (e != '') {
                                        con.txtStatusPayAmt.value =
                                            double.parse(e.replaceAll(
                                                RegExp(r'[^0-9.]'), ''));
                                        con.isStatusPayAmt.value = false;
                                      } else {
                                        con.txtStatusPayAmt.value = 0.0;
                                        con.isStatusPayAmt.value = true;
                                      }
                                    },
                                    // initialValue:
                                    //     con.txtStatusPayAmt.value,
                                  ),
                                ),
                              ],
                            ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomDropDown(
                              label: 'Type',
                              labelColor:
                                  AppColors.logoDarkBlue.withOpacity(0.7),
                              borderColor: AppColors.logoDarkBlue,
                              borderWith: 1.8,
                              item: [
                                ...con.allOptionModel.value.type!
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  return DropDownItem(
                                    itemList: {
                                      "Name": "${e.value.display}",
                                      // "Code": "${e.value.id}",
                                    },
                                  );
                                }).toList()
                              ],
                              onChange: (e) {
                                if (e != '') {
                                  con.txtTypeNew.value = e["Name"];
                                  con.isTypeNew.value = false;
                                } else {
                                  con.txtTypeNew.value = e[""];
                                  con.isTypeNew.value = true;
                                }
                              },
                              defaultValue: con.txtTypeNew.value != ''
                                  ? {
                                      "Name": con.txtTypeNew.value,
                                    }
                                  : null,
                              isValidate: con.isTypeNew.value,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: CustomTextFieldNew(
                              maxLine: 6,
                              hintText: 'Remark (optional)',
                              labelText: 'Remark (optional)',
                              labelColor:
                                  AppColors.logoDarkBlue.withOpacity(0.6),
                              onChange: (e) {
                                con.txtRemarkNew.value = e;
                              },
                              initialValue: con.txtRemarkNew.value,
                            ),
                          ),
                          ////// upload image
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            //to show image, you type like this.
                                            // File(imgpath!.path),
                                            File(con.imageFile.value.path),
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                        ],
                      ),
                    ),
                  ),
                ),
                /////
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 40, top: 10),
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
                            onActivityLogDevice(
                                userId: '${widget.coId}',
                                description: 'Submit arrear follow up');
                            // onValidateClientCommit();
                            // onValideStatus();
                            // if (con.isValidClientCom.value &&
                            //     con.isValidateStatus.value &&
                            //     con.txtReasonNew.value != '' &&
                            //     con.txtSolvingNew.value != '') {
                            //   con.testSubmit();
                            //
                            // }

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

  validSetPayFullAmount() {
    return (con.txtClientComNew.value.toLowerCase() ==
                'Pay full amount'.toLowerCase() ||
            con.txtClientComNew.value.toLowerCase() ==
                'Pay partial amount'.toLowerCase()) &&
        con.txtPayFullAmt.value != 0.0 &&
        con.txtPayFullDate.text.isNotEmpty;
  }

  validSetClientRevolving() {
    return con.txtClientComNew.value.toLowerCase() ==
            'Client agreed to do revolving loan'.toLowerCase() &&
        con.txtRevolvingDate.text.isNotEmpty &&
        con.txtDisburseDate.text.isNotEmpty;
  }

  validSetClientCollateral() {
    return con.txtClientComNew.value.toLowerCase() ==
            'Client agrees to sell collateral'.toLowerCase() &&
        con.txtCollateralSellAmt.value != 0.0 &&
        con.txtColllateralDate.text.isNotEmpty;
  }

  validSetStatusPartial() {
    return con.txtStatusNew.value.toLowerCase() ==
            'Completed for partial amount'.toLowerCase() &&
        con.txtStatusPayAmt.value != 0.0 &&
        con.txtStatusPayDate.text.isNotEmpty;
  }

  validSetLostJob() {
    return (con.txtReasonNew.value.toLowerCase() ==
                'Fail in business'.toLowerCase() ||
            con.txtReasonNew.value.toLowerCase() == 'Lost job'.toLowerCase()) &&
        con.txtJobName.isNotEmpty &&
        con.txtWorkplace.isNotEmpty;
  }

  onValidate() {
    if (con.txtClientComNew.value == 'Pay full amount' ||
        con.txtClientComNew.value == 'Pay partial amount') {
      if (con.txtPayFullAmt.value != 0.0) {
        con.isPayFullAmt.value = false;
      } else {
        con.isPayFullAmt.value = true;
      }

      if (con.txtPayFullDate.text != '') {
        con.isPayFullDate.value = false;
      } else {
        con.isPayFullDate.value = true;
      }

      // return payFull;
    }

    ////
    if (con.txtClientComNew.value == 'Client agreed to do revolving loan') {
      if (con.txtRevolvingDate.text != '') {
        con.isRevolvingDate.value = false;
      } else {
        con.isRevolvingDate.value = true;
      }
      if (con.txtDisburseDate.text != '') {
        con.isDisburseDate.value = false;
      } else {
        con.isDisburseDate.value = true;
      }
      // return revolving;
    }

    ////
    if (con.txtClientComNew.value == 'Client agrees to sell collateral') {
      if (con.txtCollateralSellAmt.value != 0.0) {
        con.isCollateralSellAmt.value = false;
      } else {
        con.isCollateralSellAmt.value = true;
      }

      if (con.txtColllateralDate.text != '') {
        con.isCollateralDate.value = false;
      } else {
        con.isCollateralDate.value = true;
      }
      // return sellCollateral;
    }

    //// status field
    if (con.txtStatusNew.value == 'Completed for partial amount') {
      if (con.txtStatusPayDate.text != '') {
        con.isStatusPayDate.value = false;
      } else {
        con.isStatusPayDate.value = true;
      }
      if (con.txtStatusPayAmt.value != 0.0) {
        con.isStatusPayAmt.value = false;
      } else {
        con.isStatusPayAmt.value = true;
      }
      // return completePartialAmt;
    }
    ////////////////// for no sub field
    if (con.txtReasonNew.value != '') {
      con.isReasonNew.value = false;
    } else {
      con.isReasonNew.value = true;
    }

    if (con.txtSolvingNew.value != '') {
      con.isSolvingNew.value = false;
    } else {
      con.isSolvingNew.value = true;
    }
    if (con.txtClientComNew.value != '') {
      con.isClientComNew.value = false;
    } else {
      con.isClientComNew.value = true;
    }
    if (con.txtStatusNew.value != '') {
      con.isStatusNew.value = false;
    } else {
      con.isStatusNew.value = true;
    }
    if (con.imageFile.value.path != '') {
      con.isImage.value = false;
    } else {
      con.isImage.value = true;
    }
    if (con.txtJobName.value != '') {
      con.isJobName.value = false;
    } else {
      con.isJobName.value = true;
    }
    if (con.txtWorkplace.value != '') {
      con.isWorkPlace.value = false;
    } else {
      con.isWorkPlace.value = true;
    }
    if (con.txtTypeNew.value != '') {
      con.isTypeNew.value = false;
    } else {
      con.isTypeNew.value = true;
    }

    if ((con.txtReasonNew.isNotEmpty &&
                (con.txtReasonNew.value.toLowerCase() ==
                        'Serious ill'.toLowerCase() ||
                    con.txtReasonNew.value.toLowerCase() ==
                        'Other'.toLowerCase()) ||
            validSetLostJob()) &&
        con.txtSolvingNew.value.isNotEmpty &&
        ((con.txtClientComNew.value.isNotEmpty &&
                con.txtClientComNew.value == "Promise to pay") ||
            validSetPayFullAmount() ||
            validSetClientRevolving() ||
            validSetClientCollateral()) &&
        ((con.txtStatusNew.isNotEmpty &&
                con.txtStatusNew.value.toLowerCase() !=
                    'Completed for partial amount'.toLowerCase()) ||
            validSetStatusPartial()) &&
        con.imageFile.value.path != '') {
      con.uploadImage(con.imageFile.value, widget.loanId!).then((imgUrl) {
        con.imagePathFile.value = json.decode(imgUrl)["imageUrl"];
      }).then((value) {
        con.onArrFollowUp(
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
          overdueAmt: widget.overdueAmt,
          loanId: widget.loanId,
          currencyCode: widget.currencyCode,
          loanBalance: widget.loanBalance,
        );
      }).then((value) => con.onClearArrFollow());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please Input Your Fields',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
          dismissDirection: DismissDirection.up,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          showCloseIcon: true,
          closeIconColor: Colors.white,
        ),
      );
    }
    // if (con.txtReasonNew.value != '' &&
    //         con.txtSolvingNew.value != '' &&
    //         con.txtClientComNew.value != '' ||
    //     payFull == true ||
    //     revolving == true ||
    //     sellCollateral == true ||
    //     completePartialAmt == true) {
    //   debugPrint('success');
    // }
  }
}
