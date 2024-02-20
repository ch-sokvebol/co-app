import 'package:chokchey_finance/app/module/policy/controllers/memoPolicyController.dart';
import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_protector/screen_protector.dart';

import '../../../../localizations/appLocalizations.dart';
import '../../log/custom/custom_memo.dart';
import 'detail_department.dart';

class PolicyMemoScreen extends StatefulWidget {
  PolicyMemoScreen({super.key});

  @override
  State<PolicyMemoScreen> createState() => _PolicyMemoScreenState();
}

class _PolicyMemoScreenState extends State<PolicyMemoScreen> {
  final memoCon = Get.put(MemoPolicyController());
  Future<void> protectorSceen() async {
    await ScreenProtector.preventScreenshotOn();
  }

  @override
  void initState() {
    protectorSceen();
    memoCon.getTopDepartment();
    // ScreenProtector.preventScreenshotOn();
    // if (Platform.isIOS) {
    //   protectorSceenIOS();
    // } else {
    //   protectorSceenAndroid();
    // }

    memoCon.getMemoPolicy();

    super.initState();
  }

  @override
  void dispose() {
    ScreenProtector.preventScreenshotOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 1,
        backgroundColor: AppColors.logolightGreen,
        leading: BackButton(),
        title: Text(
          AppLocalizations.of(context)!.translate('policy') ?? "Policy & Memo",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(
        () => memoCon.isLoadingTop.value == true &&
                memoCon.isLoadingPolicy.value == true
            ? Center(
                child: CircularProgressIndicator(
                color: logolightGreen,
              ))
            : SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // memoCon.countLogList.isEmpty
                      //     ? Text('')
                      //     : ListView.builder(
                      //         shrinkWrap: true,
                      //         itemCount: 5,
                      //         itemBuilder: (context, index) {
                      //           return CustomPoint(
                      //             title:
                      //                 memoCon.countLogList[index].description,
                      //             onTap: () {},
                      //           );
                      //         }),
                      // CustomPoint(
                      //   title: 'Example top 1',
                      //   onTap: () {},
                      // ),
                      // CustomPoint(
                      //   title: 'Example top 2',
                      //   onTap: () {},
                      // ),

                      // ...memoCon.toplList.asMap().entries.map(
                      //   (e) {
                      //     return CustomPoint(
                      //       title: e.value.title,
                      //       onTap: () {},
                      //     );
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "DEPARTMENT",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: memoCon.memoPolicyList.length,
                          itemBuilder: (context, index) {
                            return CustomTextMemo(
                              title: memoCon.memoPolicyList[index].name,
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailDepartMentScreen(
                                      memoPolicyModel:
                                          memoCon.memoPolicyList[index],
                                      // titleBar: e.value.name,
                                    ),
                                  ),
                                );
                              },
                              // title: memoCon.memoPolicyModel.value
                              //     .departmentDetails![index].title,
                              // deptID: memoCon.memoPolicyModel.value
                              //     .departmentDetails![index].id,
                            );
                          }),
                      // Column(
                      //   children: [
                      //     ...memoCon.memoPolicyList.asMap().entries.map((e) {
                      //       return Column(
                      //         children: [
                      //           CustomTextMemo(
                      //             title: e.value.name,
                      //             ontap: () {
                      //               Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       DetailDepartMentScreen(
                      //                     memoPolicyModel: e.value,
                      //                     // titleBar: e.value.name,
                      //                   ),
                      //                 ),
                      //               );
                      //             },
                      //             // title: memoCon.memoPolicyModel.value
                      //             //     .departmentDetails![index].title,
                      //             // deptID: memoCon.memoPolicyModel.value
                      //             //     .departmentDetails![index].id,
                      //           ),
                      //         ],
                      //       );
                      //     }).toList(),
                      //   ],
                      // )
                      // ListView.builder(
                      //     shrinkWrap: true,
                      //     itemCount: memoCon.memoPolicyList.length,
                      //     itemBuilder: (context, index) {
                      //       return CustomTextMemo(
                      //         title: memoCon.memoPolicyList[index].name,
                      //         ontap: () {
                      //           // debugPrint(
                      //           //     'test:${memoCon.memoPolicyModel.value.departmentDetails![index].title}');
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => DetailDepartMentScreen(
                      //                 memoPolicyModel:
                      //                     memoCon.memoPolicyModel.value,
                      //                 // title: memoCon.memoPolicyModel.value
                      //                 //     .departmentDetails![index].title,
                      //                 // deptID: memoCon.memoPolicyModel.value
                      //                 //     .departmentDetails![index].id,
                      //               ),
                      //             ),
                      //           );
                      //         },
                      //       );
                      //     }),

                      // CustomTextMemo(
                      //   title: "OPERATION",
                      //   ontap: () {
                      //     debugPrint("OPERATION");
                      //   },
                      // ),
                      // CustomTextMemo(
                      //   title: 'PRODUCT',
                      //   ontap: () {},
                      // ),
                      // CustomTextMemo(
                      //   title: "CREDIT RISK",
                      //   ontap: () {},
                      // ),
                      // CustomTextMemo(
                      //   title: 'FINANCE',
                      //   ontap: () {},
                      // ),
                      // CustomTextMemo(
                      //   title: 'PLANNING',
                      //   ontap: () {},
                      // ),
                      // CustomTextMemo(
                      //   title: 'IT',
                      //   ontap: () {},
                      // ),
                      // CustomTextMemo(
                      //   title: 'INTERNAL AUDIT',
                      //   ontap: () {},
                      // ),
                      // CustomTextMemo(
                      //   title: 'LEGAL & COMPLIANCE',
                      //   ontap: () {},
                      // ),
                      // CustomTextMemo(
                      //   title: 'MARKETING',
                      //   ontap: () {},
                      // ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
