import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:chokchey_finance/app/module/util/widget/custom_textfield.dart';
import 'package:chokchey_finance/providers/manageService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

import '../../../utils/helpers/pdf_service.dart';
import '../../../utils/helpers/sqlite_helper.dart';
import '../../offline_local_data/loan_arr_local/custom_card_par_local.dart';
import '../../home_new/model/arrear_model_new.dart';
import '../../home_new/model/loan_arrear_model_new.dart';
import '../controllers/loan_arrear_controller.dart';
import '../widgets/arrear_card.dart';
import 'package:http/http.dart' as http;

// import 'package:pdf/widgets.dart' as pw;

// class ArrearFollowUpNewss extends StatefulWidget {
//   final String? loanId;
//   final String? village;
//   final String? commune;
//   final String? district;
//   final String? province;
//   final String? customerCodes;
//   final String? customerNames;
//   final String? loanNumber;
//   final double? loanAmount;
//   final double? overdueDay;
//   final String? coName;
//   final String? coId;
//   final String? status;
//   final String? brancCode;
//   final String? brancName;
//   final String? repaymentDate;
//   final double? loanPeriod;
//   final String? createdDate;
//   final String? createdBy;
//   const ArrearFollowUpNewss(
//       {super.key,
//       this.loanId,
//       this.village,
//       this.commune,
//       this.district,
//       this.province,
//       this.customerCodes,
//       this.customerNames,
//       this.loanNumber,
//       this.loanAmount,
//       this.overdueDay,
//       this.coName,
//       this.coId,
//       this.status,
//       this.brancCode,
//       this.brancName,
//       this.repaymentDate,
//       this.loanPeriod,
//       this.createdDate,
//       this.createdBy});

//   @override
//   State<ArrearFollowUpNewss> createState() => _ArrearFollowUpNewssState();
// }

// class _ArrearFollowUpNewssState extends State<ArrearFollowUpNewss> {
//   final con = Get.put(LoanArrearController());
//   final mapCon = Get.put(MapHelperController());

//   @override
//   void initState() {
//     con.getOption();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).textTheme;
//     return CupertinoScaffold(
//       body: Builder(builder: (context) {
//         return Scaffold(
//           appBar: CustomAppBar(
//             context: context,
//             title: "Loan Arrears Follow Up",
//             centerTitle: true,
//           ),
//           body: Obx(
//             () => Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 20),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: CustomDropDown(
//                               label: 'Reasons of overdue',
//                               labelColor:
//                                   AppColors.logoDarkBlue.withOpacity(0.7),
//                               borderColor: AppColors.logoDarkBlue,
//                               borderWith: 1.8,
//                               item: [
//                                 ...con.reasonList.asMap().entries.map((e) {
//                                   return DropDownItem(
//                                     itemList: {
//                                       "Name": "${e.value['display']}",
//                                     },
//                                   );
//                                 })
//                               ],
//                               onChange: (e) {
//                                 if (e != '') {
//                                   con.txtReasonNew.value = e['Name'];
//                                   con.isReasonNew.value = false;
//                                 } else {
//                                   con.txtReasonNew.value = e[''];

//                                   con.isReasonNew.value = true;
//                                 }
//                               },
//                               defaultValue: con.txtReasonNew.value != ''
//                                   ? {
//                                       "Name": con.txtReasonNew.value,
//                                     }
//                                   : null,
//                               isValidate: con.isReasonNew.value,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: CustomDropDown(
//                               label: 'Solving status',
//                               labelColor:
//                                   AppColors.logoDarkBlue.withOpacity(0.7),
//                               borderColor: AppColors.logoDarkBlue,
//                               borderWith: 1.8,
//                               item: [
//                                 ...con.solvingList.asMap().entries.map((e) {
//                                   return DropDownItem(
//                                     itemList: {
//                                       "Name": "${e.value['display']}",
//                                     },
//                                   );
//                                 })
//                               ],
//                               onChange: (e) {
//                                 if (e != '') {
//                                   con.txtSolvingNew.value = e['Name'];
//                                   con.isSolvingNew.value = false;
//                                 } else {
//                                   con.txtSolvingNew.value = e[''];

//                                   con.isSolvingNew.value = true;
//                                 }
//                               },
//                               defaultValue: con.txtSolvingNew.value != ''
//                                   ? {
//                                       "Name": con.txtSolvingNew.value,
//                                     }
//                                   : null,
//                               isValidate: con.isSolvingNew.value,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: CustomDropDown(
//                               label: 'Client commitment *',
//                               labelColor:
//                                   AppColors.logoDarkBlue.withOpacity(0.7),
//                               borderColor: AppColors.logoDarkBlue,
//                               borderWith: 1.8,
//                               item: [
//                                 ...con.clientCommitList
//                                     .asMap()
//                                     .entries
//                                     .map((e) {
//                                   return DropDownItem(
//                                     itemList: {
//                                       "Name": "${e.value['display']}",
//                                       // "Code": "${e.value.id}",
//                                     },
//                                   );
//                                 })
//                               ],
//                               onChange: (e) {
//                                 if (e != '') {
//                                   con.txtClientComNew.value = e['Name'];

//                                   /// reset field after select change
//                                   con.txtCollateralSellAmt.value = 0.0;
//                                   con.txtColllateralDate.text = '';
//                                   con.txtRevolvingDate.text = '';
//                                   con.txtDisburseDate.text = '';
//                                   con.txtPayFullAmt.value = 0.0;
//                                   con.txtPayFullDate.text = '';

//                                   // con.txtClientCom.value = e['Code'];
//                                   con.isClientComNew.value = false;
//                                 } else {
//                                   con.txtClientComNew.value = e[''];
//                                   // con.txtTitleSub.value = e[''];
//                                   con.isClientComNew.value = true;
//                                 }
//                                 // debugPrint('leng:${con.txtClientComNew.value}');
//                               },
//                               defaultValue: con.txtClientComNew.value != ''
//                                   ? {
//                                       "Name": con.txtClientComNew.value,
//                                     }
//                                   : null,
//                               isValidate: con.isClientComNew.value,
//                             ),
//                           ),

//                           /////////////////////////1
//                           if (con.txtClientComNew.value.toLowerCase() !=
//                                   'Promise to pay'.toLowerCase() &&
//                               con.txtClientComNew.value != '' &&
//                               con.txtClientComNew.value.toLowerCase() !=
//                                   'Client agreed to do revolving loan'
//                                       .toLowerCase() &&
//                               con.txtClientComNew.value.toLowerCase() !=
//                                   'Client agrees to sell collateral'
//                                       .toLowerCase())
//                             Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 20, right: 20, top: 20),
//                                   child: CustomDatePicker(
//                                     controller: con.txtPayFullDate,
//                                     hinText: 'Pay Date *',
//                                     isValidate: con.isPayFullDate.value,
//                                   ),
//                                 ),
//                                 // if (con.txtClientCom.value != 'Promise to pay' &&
//                                 //     con.txtClientCom.value != '')
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 20, right: 20, top: 20),
//                                   child: CustomTextFieldNew(
//                                     inputFormatterList: <TextInputFormatter>[
//                                       FilteringTextInputFormatter.digitsOnly
//                                     ],
//                                     keyboardType: TextInputType.number,
//                                     hintText: 'Pay Amount *',
//                                     onChange: (e) {
//                                       if (e.isNotEmpty) {
//                                         con.txtPayFullAmt.value = double.parse(
//                                             e.replaceAll(
//                                                 RegExp(r'[^0-9.]'), ''));
//                                         // double.parse(e.replaceAll(RegExp(r'[^0-9.]')));
//                                         con.isPayFullAmt.value = false;
//                                       } else {
//                                         con.txtPayFullAmt.value = 0.0;
//                                         // double.parse('');
//                                         con.isPayFullAmt.value = true;
//                                       }
//                                     },
//                                     isValidate: con.isPayFullAmt.value,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ////////////////////////
//                           if (con.txtClientComNew.value ==
//                                   'Client agreed to do revolving loan' &&
//                               con.txtClientComNew.value != '')
//                             Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 20, right: 20, top: 20),
//                                   child: CustomDatePicker(
//                                     controller: con.txtRevolvingDate,
//                                     hinText: 'Do revolving loan date *',
//                                     isValidate: con.isRevolvingDate.value,
//                                   ),
//                                 ),
//                                 // if (con.txtClientCom.value != 'Promise to pay' &&
//                                 //     con.txtClientCom.value != '')
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 20, right: 20, top: 20),
//                                   child: CustomDatePicker(
//                                     controller: con.txtDisburseDate,
//                                     hinText: 'Disbursement Date*',
//                                     isValidate: con.isDisburseDate.value,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ///////// client aggree
//                           if (con.txtClientComNew.value ==
//                                   'Client agrees to sell collateral' &&
//                               con.txtClientComNew.value != '')
//                             Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 20, right: 20, top: 20),
//                                   child: CustomDatePicker(
//                                     isValidate: con.isCollateralDate.value,
//                                     controller: con.txtColllateralDate,
//                                     hinText: 'Sell Date *',
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 20, right: 20, top: 20),
//                                   child: CustomTextFieldNew(
//                                     keyboardType: TextInputType.number,
//                                     isValidate: con.isCollateralSellAmt.value,
//                                     hintText: 'Sell Amount *',
//                                     onChange: (e) {
//                                       if (e.isNotEmpty) {
//                                         con.txtCollateralSellAmt.value =
//                                             double.parse(e.replaceAll(
//                                                 RegExp(r'[^0-9.]'), ''));
//                                         // double.parse(e);
//                                         con.isCollateralSellAmt.value = false;
//                                       } else {
//                                         con.txtCollateralSellAmt.value = 0.0;
//                                         con.isCollateralSellAmt.value = true;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           CustomDropDown(
//                             label: 'Status',
//                             labelColor: AppColors.logoDarkBlue.withOpacity(0.7),
//                             borderColor: AppColors.logoDarkBlue,
//                             borderWith: 1.8,
//                             item: [
//                               ...con.statusList.asMap().entries.map((e) {
//                                 return DropDownItem(
//                                   itemList: {
//                                     "Name": "${e.value['display']}",
//                                     // "Code": "${e.value.id}",
//                                   },
//                                 );
//                               })
//                             ],
//                             onChange: (e) {
//                               if (e != '') {
//                                 con.txtStatusNew.value = e["Name"];
//                                 con.isStatusNew.value = false;
//                               } else {
//                                 con.txtStatusNew.value = e[""];
//                                 con.isStatusNew.value = true;
//                               }
//                             },
//                             defaultValue: con.txtStatusNew.value != ''
//                                 ? {
//                                     "Name": con.txtStatusNew.value,
//                                   }
//                                 : null,
//                             isValidate: con.isStatusNew.value,
//                           ),
//                           if (con.txtStatusNew.value != '' &&
//                               con.txtStatusNew.value ==
//                                   'Completed for partial amount')
//                             Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 20, right: 20, top: 20),
//                                   child: CustomDatePicker(
//                                     controller: con.txtStatusPayDate,
//                                     hinText: 'Pay Date *',
//                                     isValidate: con.isStatusPayDate.value,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 20, right: 20, top: 20),
//                                   child: CustomTextFieldNew(
//                                     keyboardType: TextInputType.number,
//                                     isValidate: con.isStatusPayAmt.value,
//                                     hintText: 'Pay Amount *',
//                                     onChange: (e) {
//                                       if (e.isNotEmpty) {
//                                         con.txtStatusPayAmt.value =
//                                             double.parse(e.replaceAll(
//                                                 RegExp(r'[^0-9.]'), ''));

//                                         con.isStatusPayAmt.value = false;
//                                       } else {
//                                         con.txtStatusPayAmt.value = 0.0;
//                                         con.isStatusPayAmt.value = true;
//                                       }
//                                     },
//                                     // initialValue:
//                                     //     con.txtStatusPayAmt.value.toString(),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 20, right: 20, top: 20),
//                             child: CustomTextFieldNew(
//                               maxLine: 6,
//                               hintText: 'Remark',
//                               onChange: (e) {
//                                 con.txtRemarkNew.value = e;
//                               },
//                               initialValue: con.txtRemarkNew.value,
//                             ),
//                           ),
//                           ////// upload image
//                           con.imageFile.value.path != ''
//                               ? Container(
//                                   width: 180,
//                                   height: 180,
//                                   child: Stack(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 20, vertical: 20),
//                                         child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           child: Image.file(
//                                             //to show image, you type like this.
//                                             // File(imgpath!.path),
//                                             File(con.imageFile.value.path),
//                                             fit: BoxFit.cover,
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             height: 300,
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         right: 0,
//                                         child: IconButton(
//                                             onPressed: () {
//                                               con.imageFile.value = File('');
//                                             },
//                                             icon: CircleAvatar(
//                                               backgroundColor: Colors.black87,
//                                               child: Icon(
//                                                 Icons.close,
//                                                 color: Colors.white,
//                                               ),
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               : GestureDetector(
//                                   onTap: () {
//                                     myAlert(context: context);
//                                     // ImagePickerHelper.myAlert(
//                                     //     file: con.imageFile.value, context: context);
//                                   },
//                                   child: Container(
//                                     margin: EdgeInsets.only(top: 30, right: 20),
//                                     width: 160,
//                                     height: 160,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.black12,
//                                         border: Border.all(
//                                             color: con.isImage.value == true
//                                                 ? Colors.red
//                                                 : Colors.black12)),
//                                     child: Center(
//                                       child: Image.asset(
//                                         'assets/images/cornerCa.png',
//                                         width: 100,
//                                         height: 100,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 /////
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 20, right: 20, bottom: 40, top: 10),
//                   child: con.isLoadingArrUp.value == true
//                       ? Container(
//                           padding: EdgeInsets.symmetric(vertical: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: AppColors.logoDarkBlue,
//                           ),
//                           width: double.infinity,
//                           child: SpinKitThreeBounce(
//                             color: Colors.white,
//                             size: 25,
//                           ),
//                         )
//                       : CustomButton(
//                           title: 'Submit',
//                           textStyle: theme.titleMedium!.copyWith(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           color:
//                               // con.txtReasonNew.value.isNotEmpty &&
//                               //         con.txtSolvingNew.value.isNotEmpty &&
//                               //         (validSetPayFullAmount() ||
//                               //             validSetClientRevolving()) &&
//                               //         con.txtStatusNew.value.isNotEmpty
//                               //     ?
//                               AppColors.logoDarkBlue,
//                           // : Colors.black38,
//                           onPressed: () {
//                             // onMainValidate();
//                             testValidate();
//                             // onValidateClientCommit();
//                             // onValideStatus();
//                             // if (con.isValidClientCom.value &&
//                             //     con.isValidateStatus.value &&
//                             //     con.txtReasonNew.value != '' &&
//                             //     con.txtSolvingNew.value != '') {
//                             //   con.testSubmit();
//                             //   debugPrint('okkkkk');
//                             // }
//                             // debugPrint('lll:${con.imageFile.value}');

//                             // con.uploadImage(con.imageFile.value);
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   void myAlert({BuildContext? context, File? img}) {
//     showDialog(
//         context: context!,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             title: Text('Please choose media to select'),
//             content: Container(
//               height: MediaQuery.of(context).size.height / 6,
//               child: Column(
//                 children: [
//                   ElevatedButton(
//                     //if user click this button, user can upload image from gallery
//                     onPressed: () {
//                       Navigator.pop(context);
//                       // getImages();
//                       con.onChooseImage(
//                           media: ImageSource.gallery, fileimg: img);
//                       // con.pickImg1(
//                       //     context: context,
//                       //     imageSource: ImageSource.gallery,
//                       //     files: con.imageFile.value);
//                       con.update();
//                       setState(() {});
//                       // setState(() {
//                       //   ImagePickerHelper.onChooseImage(
//                       //       media: ImageSource.gallery,
//                       //       fileImage: con.imageFile.value);
//                       // });
//                     },
//                     child: Row(
//                       children: [
//                         Icon(Icons.image),
//                         Text('From Gallery'),
//                       ],
//                     ),
//                   ),
//                   ElevatedButton(
//                     //if user click this button. user can upload image from camera
//                     onPressed: () {
//                       Navigator.pop(context);
//                       // getImage(ImageSource.camera);
//                       con.onChooseImage(media: ImageSource.camera);
//                     },
//                     child: Row(
//                       children: [
//                         Icon(Icons.camera),
//                         Text('From Camera'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   validSetPayFullAmount() {
//     return (con.txtClientComNew.value.toLowerCase() ==
//                 'Pay full amount'.toLowerCase() ||
//             con.txtClientComNew.value.toLowerCase() ==
//                 'Pay partial amount'.toLowerCase()) &&
//         con.txtPayFullAmt.value != 0.0 &&
//         con.txtPayFullDate.text.isNotEmpty;
//   }

//   validSetClientRevolving() {
//     return con.txtClientComNew.value.toLowerCase() ==
//             'Client agreed to do revolving loan'.toLowerCase() &&
//         con.txtRevolvingDate.text.isNotEmpty &&
//         con.txtDisburseDate.text.isNotEmpty;
//   }

//   validSetClientCollateral() {
//     return con.txtClientComNew.value.toLowerCase() ==
//             'Client agrees to sell collateral'.toLowerCase() &&
//         con.txtCollateralSellAmt.value != 0.0 &&
//         con.txtColllateralDate.text.isNotEmpty;
//   }

//   validSetStatusPartial() {
//     return con.txtStatusNew.value.toLowerCase() ==
//             'Completed for partial amount'.toLowerCase() &&
//         con.txtStatusPayAmt.value != 0.0 &&
//         con.txtStatusPayDate.text.isNotEmpty;
//   }

//   bool? payFull = true;
//   bool? revolving = true;
//   bool? sellCollateral = true;
//   bool? completePartialAmt = true;
//   testValidate() {
//     if (con.txtClientComNew.value == 'Pay full amount' ||
//         con.txtClientComNew.value == 'Pay partial amount') {
//       if (con.txtPayFullAmt.value != 0.0) {
//         con.isPayFullAmt.value = false;
//       } else {
//         con.isPayFullAmt.value = true;
//       }

//       if (con.txtPayFullDate.text != '') {
//         con.isPayFullDate.value = false;
//       } else {
//         con.isPayFullDate.value = true;
//       }

//       // return payFull;
//     }

//     ////
//     if (con.txtClientComNew.value == 'Client agreed to do revolving loan') {
//       if (con.txtRevolvingDate.text != '') {
//         con.isRevolvingDate.value = false;
//       } else {
//         con.isRevolvingDate.value = true;
//       }
//       if (con.txtDisburseDate.text != '') {
//         con.isDisburseDate.value = false;
//       } else {
//         con.isDisburseDate.value = true;
//       }
//       // return revolving;
//     }

//     ////
//     if (con.txtClientComNew.value == 'Client agrees to sell collateral') {
//       if (con.txtCollateralSellAmt.value != 0.0) {
//         con.isCollateralSellAmt.value = false;
//       } else {
//         con.isCollateralSellAmt.value = true;
//       }

//       if (con.txtColllateralDate.text != '') {
//         con.isCollateralDate.value = false;
//       } else {
//         con.isCollateralDate.value = true;
//       }
//       // return sellCollateral;
//     }

//     //// status field
//     if (con.txtStatusNew.value == 'Completed for partial amount') {
//       if (con.txtStatusPayDate.text != '') {
//         con.isStatusNew.value = false;
//       } else {
//         con.isStatusNew.value = true;
//       }
//       if (con.txtStatusPayAmt.value != 0.0) {
//         con.isStatusPayAmt.value = false;
//       } else {
//         con.isStatusPayAmt.value = true;
//       }
//       // return completePartialAmt;
//     }
//     ////////////////// for no sub field
//     if (con.txtReasonNew.value != '') {
//       con.isReasonNew.value = false;
//     } else {
//       con.isReasonNew.value = true;
//     }

//     if (con.txtSolvingNew.value != '') {
//       con.isSolvingNew.value = false;
//     } else {
//       con.isSolvingNew.value = true;
//     }
//     if (con.txtClientComNew.value != '') {
//       con.isClientComNew.value = false;
//     } else {
//       con.isClientComNew.value = true;
//     }
//     if (con.txtStatusNew.value != '') {
//       con.isStatusNew.value = false;
//     } else {
//       con.isStatusNew.value = true;
//     }
//     ////////////check for submit
//     // if (con.txtReasonNew.value != '' &&
//     //         con.txtSolvingNew.value != '' &&
//     //         con.txtClientComNew.value != '' &&
//     //         con.txtStatusNew.value != '' ||
//     //     con.txtClientComNew.value == 'Pay full amount' &&
//     //         con.txtClientComNew.value == 'Pay partial amount' &&
//     //         con.txtPayFullAmt.value != '' &&
//     //         con.txtPayFullDate.text != '' ||
//     //     con.txtClientComNew.value == 'Client agreed to do revolving loan' &&
//     //         con.txtRevolvingDate.text != '' &&
//     //         con.txtDisburseDate.text != '' ||
//     //     con.txtClientComNew.value == 'Client agrees to sell collateral' &&
//     //         con.txtCollateralSellAmt.value != '' &&
//     //         con.txtColllateralDate.text != '')

//     if (con.txtReasonNew.value.isNotEmpty &&
//         con.txtSolvingNew.value.isNotEmpty &&
//         ((con.txtClientComNew.value.isNotEmpty &&
//                 con.txtClientComNew.value == "Promise to pay") ||
//             validSetPayFullAmount() ||
//             validSetClientRevolving() ||
//             validSetClientCollateral()) &&
//         ((con.txtStatusNew.isNotEmpty &&
//                 con.txtStatusNew.value.toLowerCase() !=
//                     'Completed for partial amount'.toLowerCase()) ||
//             validSetStatusPartial()) &&
//         con.imageFile.value.path.isNotEmpty) {
//       con.onArrFollowUp();
//     }
//     // if (con.txtReasonNew.value != '' &&
//     //         con.txtSolvingNew.value != '' &&
//     //         con.txtClientComNew.value != '' ||
//     //     payFull == true ||
//     //     revolving == true ||
//     //     sellCollateral == true ||
//     //     completePartialAmt == true) {
//     //   debugPrint('success');
//     // }
//   }
// }

// class PdfConScreen extends StatelessWidget {
//   PdfConScreen({super.key});
//   late PdfViewerController _pdfViewerController;
//   @override
//   Widget build(BuildContext context) {
//     _pdfViewerController = PdfViewerController();
//     return Scaffold(
//       appBar: AppBar(),
//       body: SfPdfViewer.asset(
//         'assets/Credit_Operation_Manual.pdf',
//         controller: _pdfViewerController,
//         pageSpacing: 0,
//         currentSearchTextHighlightColor: Colors.red.withOpacity(0.7),
//         otherSearchTextHighlightColor: Colors.red.withOpacity(0.5),
//       ),
//     );
//   }
// }

// class PdfPreviewPage extends StatelessWidget {
//   String? text;
//   PdfPreviewPage(this.text, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('PDF Preview'),
//         ),
//         body: TextButton(
//             onPressed: () {
//               makePdf();
//             },
//             child: Text('Pdf'))
//         // PDFView(
//         //   build: (context) => makePdf(),
//         // ),
//         );
//   }

//   Future<Uint8List> makePdf() async {
//     final pdf = pw.Document();
//     final ByteData bytes = await rootBundle.load('assets/images/approval.png');
//     final Uint8List byteList = bytes.buffer.asUint8List();
//     pdf.addPage(pw.Page(
//         margin: const pw.EdgeInsets.all(10),
//         pageFormat: PdfPageFormat.a4,
//         build: (context) {
//           return pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: [
//                       pw.Header(text: "About Cat", level: 1),
//                       pw.Image(pw.MemoryImage(byteList),
//                           fit: pw.BoxFit.fitHeight, height: 100, width: 100)
//                     ]),
//                 pw.Divider(borderStyle: pw.BorderStyle.dashed),
//                 pw.Paragraph(text: text),
//               ]);
//         }));
//     return pdf.save();
//   }
// }

class PdfScreen extends StatelessWidget {
  const PdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TextButton(
          onPressed: () {
            onCreatePDF();
          },
          child: Text('Go to download Pdf')),
    );
  }

  // class PdfConvertService {
  Future<void> onCreatePDF() async {
    final PdfDocument document = PdfDocument();
    final page = document.pages.add();
    page.graphics.drawString(
        'Welcome to my pdf', PdfStandardFont(PdfFontFamily.helvetica, 28));
    page.graphics.drawImage(
        PdfBitmap(await _readImageData('credit_policy.png')),
        Rect.fromLTWH(0, 100, 300, 300));

    List<int> byte = await document.save();
    document.dispose();
    saveAndLaunchFile(byte, 'output.pdf');
    //  final page = document.pages.add();
  }
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

class LocalDataScreen extends StatefulWidget {
  // final int? index;
  const LocalDataScreen({
    super.key,
  });

  @override
  State<LocalDataScreen> createState() => _LocalDataScreenState();
}

class _LocalDataScreenState extends State<LocalDataScreen> {
  final con = Get.put(LoanArrearController());
  SqliteHelper? sqliteHelper;
  late Database database;
  List<dynamic> arrearlist = [];
  bool isLoading = false;
  Future<void> getData() async {
    setState(() {
      Future.delayed(Duration(seconds: 1), () async {
        arrearlist =
            await sqliteHelper!.queryData(sql: "Select * from HomeParArrear");
      });
    });
  }

  onGetLocal() async {
// if(sqliteHelper.database.)
    // sqliteHelper!.onCreateTable();
    // await sqliteHelper!.onDropTable("Arrears");

    // await sqliteHelper!.runQuery(
    //     'INSERT INTO User(id, name, age, gender) VALUES (1, "yTest", "14", "female")');

    // debugPrint('hell:$res1');

    await sqliteHelper!.runQuery(
        'INSERT INTO HomeParArrear(parRatio1, parRatio14, parRatio30, parRatio60, parRatio90, parAcc1, parAcc14, parAcc30, parAcc60, parAcc90, parAmt1, parAmt14, parAmt30, parAmt60, parAmt90, totalParAcc,totalParAmt) VALUES (${con.ratioPar1.value},${con.ratioPar14.value},${con.ratioPar30.value},${con.ratioPar60.value},${con.ratioPar90.value},${con.modelNew.value.arrear1Day!.length},${con.modelNew.value.arrear14Days!.length},${con.modelNew.value.arrear30Days!.length},${con.modelNew.value.arrear60Days!.length}, ${con.modelNew.value.arrear90Days!.length},${con.totalAmount1.value},${con.totalAmount2.value},${con.totalAmount3.value},${con.totalAmount4.value},${con.totalAmount5.value},${con.modelNew.value.allArrear!.length},${con.totalAmountAll.value})');
    //     // sql:
    //     //     'INSERT INTO HomeParArrear (parRatio1, parRatio14, parRatio30, parRatio60, parRatio90, parAcc1, parAcc14, parAcc30, parAcc60, parAcc90, parAmt1, parAmt14, parAmt30, parAmt60, parAmt90, totalParAcc,totalParAmt) VALUES ("a","b","c","d","e","f","g","h","i", "j","k","l","m","n","o","p","q")')
    //     .then((value) {

    // arrearlist = res;
    debugPrint('wwwwweee:${arrearlist}');
    // });
  }

// con
  List<dynamic> allArrListLocal = [];
  onGetParDetail() async {
    Future.delayed(Duration(seconds: 1), () async {
      allArrListLocal =
          await sqliteHelper!.queryData(sql: 'Select * from ParArrearDetail');
      // debugPrint('test:$res');
    });
  }

  // List<ArrearModelNew> allArrearList = [];
  onInsertArrear(List<ArrearModelNew> arrList) async {
    arrList.map((e) async {
      await sqliteHelper!.runQuery('''INSERT INTO ParArrearDetail(
        overdueDays, 
        customerName,
        cellPhoneNo, 
        totalAmount1,
        paymentApplyDate, 
        employeeName, 
        loanAmount, 
        loanPeriodMonthlyCount,
        branchLocalName, 
        refereneceEmployeeNo, 
        currencyCode,
        postalAddress,
        overdueInterest, 
        repayPrincipal, 
        collateralMaintenanceFee, 
        repayInterest, 
        loanAccountNo,
        villageName, 
        communeName,
        districtName1,
        provinceName, 
        customerNo, 
        loanBranchCode, 
        branchName) VALUES (
        "${e.overdueDays}",
        "${e.customerName}", 
       "${e.cellPhoneNo}", 
        ${e.totalAmount1}, 
       "${e.paymentApplyDate}", 
        "${e.employeeName}", 
        ${e.loanAmount}, 
        ${e.loanPeriodMonthlyCount},
        "${e.branchLocalName}", 
        "${e.refereneceEmployeeNo}",
       "${e.currencyCode}", 
        "${e.postalAddress}", 
        ${e.overdueInterest}, 
        ${e.repayPrincipal}, 
        ${e.collateralMaintenanceFee}, 
        ${e.repayInterest}, 
        "${e.loanAccountNo}",
        "${e.villageName}",
        "${e.communeName}", 
        "${e.districtName1}", 
        "${e.provinceName}", 
        "${e.customerNo}", 
        "${e.loanBranchCode}", 
        "${e.branchName}")''');
    }).toList();
  }

  @override
  void initState() {
    sqliteHelper = SqliteHelper();
    debugPrint('hiii:${arrearlist}');
    debugPrint('leng:${allArrListLocal.length}');
    onGetParDetail();
    // setState(() {
    getData();
    // });
    setState(() {});

    // sqliteHelper!.resQuery(
    //     "create table if not exists Test(name varchar,phone varchar)");
    // sqliteHelper!
    //     .runQuery("INSERT INTO User(name,age,gender) values (yTest,14,female)");
    // onGetLocal();
    super.initState();
  }

  List<LoanArrearModelNew> arrModelLocal = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TextButton(
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => ListArrLocal()));
            //     },
            //     child: Text('Navigator')),
            TextButton(
                onPressed: () {
                  // con.modelNew.value.allArrear!.asMap().entries.map((e) {
                  //   e.value
                  // });
                  onGetLocal();
                  // onInsertArrear(con.modelNew.value.allArrear!);
                },
                child: Text("insert")),
            TextButton(
                onPressed: () async {
                  // debugPrint('my get data222:${arrearlist[0]['parRatio1']}');
                  getData();
                  onGetParDetail();
                },
                child: Text('get data')),

            // ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: arrearlist.length,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         children: [Text('${arrearlist[index]['totalParAmt']}')],
            //       );
            //     }),
            // FutureBuilder(builder: (context,index){

            // })
            // ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: arrearlist.length,
            //     itemBuilder: (context, index) {
            //       return
            CustomCardParLocal(),
            // }),
            ListView.builder(
                shrinkWrap: true,
                itemCount: allArrListLocal.length,
                itemBuilder: (context, index) {
                  return CustomArrearCard(
                    name: allArrListLocal[index]['customerName'],
                    paymentDate: allArrListLocal[index]['paymentApplyDate'],
                    amount: allArrListLocal[index]['totalAmount1'],
                    parAmount: allArrListLocal[index]['overdueDays'],
                    currencyCode: allArrListLocal[index]['currencyCode'],
                    loanID: allArrListLocal[index]['loanAccountNo'],
                    empName: allArrListLocal[index]['employeeName'],
                  );
                })
            // CustomArrearCard(
            //     name: '',
            //     paymentDate: '20230510',
            //     amount: arrearlist[0]['totalParAmt'],
            //     parAmount: arrearlist[0]['totalParAmt'],
            //     currencyCode: '',
            //     loanID: '',
            //     empName: ''),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PushNotificationScreen extends StatelessWidget {
  PushNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(GetPushNotification());
    return Scaffold(
      appBar: AppBar(
        title: Text('Push notification'),
      ),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: CustomTextFieldNew(
                hintText: 'Title',
                labelText: 'Title',
                onChange: (e) {
                  if (e.isNotEmpty) {
                    con.txtTitle.value = e;
                  } else {
                    con.txtTitle.value = "";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: CustomTextFieldNew(
                hintText: 'Body',
                labelText: 'Body',
                onChange: (e) {
                  if (e.isNotEmpty) {
                    con.txtBody.value = e;
                  } else {
                    con.txtBody.value = "";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: CustomTextFieldNew(
                hintText: 'To',
                labelText: 'To',
                onChange: (e) {
                  if (e.isNotEmpty) {
                    con.txtTo.value = int.parse(e);
                  } else {
                    con.txtTo.value = 0;
                  }
                },
              ),
            ),
            ...con.addMoreList.asMap().entries.map((e) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    CustomTextFieldNew(
                      hintText: 'Device Id',
                      labelText: 'Device Id',
                      onChange: (e) {
                        if (e.isNotEmpty) {
                          con.txtDeviceId.value = e;
                        } else {
                          con.txtDeviceId.value = "";
                        }
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          // con.selectAddList.addAll(con.addMoreList);
                          e.key + 1;
                        },
                        icon: Icon(Icons.add_circle)),
                  ],
                ),
              );
            }).toList(),
            TextButton(
                onPressed: () {
                  con.onPushNoti(con.txtTo.value);
                },
                child: Text('Start Push'))
          ],
        ),
      ),
    );
  }
}

class GetPushNotification extends GetxController {
  final addMoreList = <DeviceModel>[].obs;
  final selectAddList = <int>[].obs;
  final txtTitle = ''.obs;
  final txtBody = ''.obs;
  final txtTo = 0.obs;
  final txtDeviceId = ''.obs;
  final isLoadingPush = false.obs;
  Future<void> onPushNoti(int? userCode) async {
    final url = Uri.parse('$baseURLInternal/ArrNotifi/arr_msg_user/$userCode');
    final header = {'Content-Type': 'application/json'};
    final body = json.encode({
      "title": "${txtTitle.value}",
      "contents": "${txtBody.value}",
      // "deviceId": [
      //   {
      //     "deviceid":
      //         "e-7-rgj8SW-RSO8Xo4O_tb:APA91bEDdFBzyjYnqpwbJ9ld-M34DA_xl6uEzTnC-EiT5TEwTBYCIGpA3w-TKg3RSXFBgmE0pqL07rzeL69kxbBilHq33ylRVtoAoMpHzltxxhoTxHuhpknBhAfNNAICCFSkUYd9ouX3",
      //     "status": 1,
      //     "usercode": "102550"
      //   },
      //   {
      //     "deviceid":
      //         "elm147I6iU55oKKxi9Pbad:APA91bGWg7iROWPEfm1NhckCOEss8writjhdq0OHZgy828PAbidw3AlHfNDnCh17C5zryfu4U9-JrPbzq6ngWtXjMQBYwT3jylm3oScFK6hpVbrmUdncGeaaHFKISlmG3NySitcxGueW",
      //     "status": 1,
      //     "usercode": "102550"
      //   }
      // ],
      // "status": 1
    });
    try {
      debugPrint('okkk==========:');

      final res = await http.post(url, headers: header, body: body);
      debugPrint('heee==========:');

      if (res.statusCode == 200) {
        var resJson = json.decode(res.body);
        debugPrint('hii==========:${resJson}');
      } else {
        debugPrint('Erorr==========:${res.statusCode}');
      }
    } catch (e) {}
  }
}

class DeviceModel {
  final int? id;
  final String? tokenID;
  DeviceModel(this.id, this.tokenID);
}
