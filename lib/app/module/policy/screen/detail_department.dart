import 'package:chokchey_finance/app/module/policy/controllers/memoPolicyController.dart';
import 'package:chokchey_finance/app/module/policy/models/memo_policy_model.dart';
import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_protector/screen_protector.dart';

import '../../../widgets/inapp_webview.dart';
import '../../log/custom/custom_title_policy.dart';

class DetailDepartMentScreen extends StatefulWidget {
  final int? deptID;
  final String? title;
  final String? date;
  final MemoPolicyModel? memoPolicyModel;
  DetailDepartMentScreen({
    super.key,
    this.deptID,
    this.title,
    this.date,
    this.memoPolicyModel,
  });

  @override
  State<DetailDepartMentScreen> createState() => _DetailDepartMentScreenState();
}

class _DetailDepartMentScreenState extends State<DetailDepartMentScreen> {
  final con = Get.put(MemoPolicyController());

  Future<void> protectorSceen() async {
    await ScreenProtector.preventScreenshotOn();
  }

  @override
  void initState() {
    con.getMemoPolicyDetail(id: widget.memoPolicyModel!.id);
    protectorSceen();
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
        backgroundColor: AppColors.logolightGreen,
        leading: BackButton(),
        title: Text(
          "${widget.memoPolicyModel!.name}",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(left: 10),
        //     child: IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.search,
        //         size: 28,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.filter_list,
        //         size: 28,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Obx(
            () => con.isLoadingDeptDetail.value == true
                ? Center(
                    child: CircularProgressIndicator(
                    color: logolightGreen,
                  ))
                : Column(
                    children: [
                      ...con.deptDetailList.asMap().entries.map((e) {
                        return DetailTitlePolicyScreen(
                          title: e.value.title,
                          type: e.value.type,
                          releaseDate: e.value.releasedate,
                          createDate: e.value.createdate,
                          onTab: e.value.url == null
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          // WebViewAppScreen(
                                          //       url: '${e.value.url}',
                                          //       title: e.value.type,
                                          //     )),
                                          InAppWebviewScreen(
                                            url: '${e.value.url}',
                                            title: e.value.type,
                                          )),
                                    ),
                                  );
                                },
                        );
                      }).toList(),
                      // ...memoPolicyModel!.departmentDetails!.asMap().entries.map((e) {
                      //   return DetailTitlePolicyScreen(
                      //     title: e.value.title,
                      //     type: e.value.type,
                      //     releaseDate: e.value.releasedate,
                      //     createDate: e.value.createdate,
                      //     onTab: e.value.url == null
                      //         ? null
                      //         : () {
                      //             Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: ((context) => WebViewApp(
                      //                       url: '${e.value.url}',
                      //                     )),
                      //               ),
                      //             );
                      //           },
                      //   );
                      // }),
                    ],
                  ),
          )
          // Column(children: [
          //   DetailTitlePolicyScreen(
          //     title: 'Attendance Implementation',
          //     // date: '04-01-2023',
          //   ),
          //   DetailTitlePolicyScreen(
          //     title: 'Staff movement & Promotion',
          //     // date: '03-02-2023',
          //   ),
          // ]),
          ),
    );
  }
}
