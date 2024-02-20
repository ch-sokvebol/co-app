import 'package:chokchey_finance/app/module/loan_arrear/controllers/loan_arrear_controller.dart';
import 'package:chokchey_finance/app/module/loan_arrear/models/Get_arr_follow_up_model.dart';
import 'package:chokchey_finance/app/module/loan_arrear/screens/report_arr_follup_card_detail.dart';
import 'package:chokchey_finance/app/widgets/custom_app_bar.dart';
import 'package:chokchey_finance/utils/storages/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/format_date.dart';

class ReportArrFollowUp extends StatefulWidget {
  final String? loanNumber;
  final String? empCode;
  final String? branchCode;
  const ReportArrFollowUp(
      {super.key, this.loanNumber, this.empCode, this.branchCode});

  @override
  State<ReportArrFollowUp> createState() => _ReportArrFollowUpState();
}

class _ReportArrFollowUpState extends State<ReportArrFollowUp> {
  final con = Get.put(LoanArrearController());
  String? typeUser;
  onType() async {
    var user = await storage.read(key: 'user_type');
    setState(() {
      typeUser = user;
    });
  }

  @override
  void initState() {
    onType();
    if (typeUser == "CO") {
      con.getArrFollowUp(
        loanNumber: widget.loanNumber,
        empCode: widget.empCode,
        branchCode: '',
      );
      debugPrint('CO');
    } else if (typeUser == "BM") {
      con.getArrFollowUp(
        loanNumber: widget.loanNumber,
        empCode: '',
        branchCode: widget.branchCode,
      );
      debugPrint('BM');
    } else {
      con.getArrFollowUp(
        loanNumber: widget.loanNumber,
        empCode: '',
        branchCode: '',
      );
      debugPrint('MNG');
    }
    // debugPrint(
    //     "hiii:${con.getArrFollowModel.value.loannumber} : ${con.getArrFollowModel.value.branchcode}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'History',
        centerTitle: true,
      ),
      body: Obx(() => con.isLoadingGetFollowUp.value == true
          ? SpinKitFadingCircle(
              color: Colors.black38,
            )
          : con.getArrFollowList.isEmpty
              ? Center(
                  child: Text(
                  'No History',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 16),
                ))
              : Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ListView.builder(
                      itemCount: con.getArrFollowList.length,
                      itemBuilder: (context, index) {
                        return _customReportCard(
                            context, con.getArrFollowList[index]);
                      }),
                )),
    );
  }

  Widget _customReportCard(
      BuildContext context, GetArrFollowUpModel getArrFollowUpModel) {
    final theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportArrFollowUpDetail(
              getArrear: getArrFollowUpModel,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                spreadRadius: 3,
                color: Colors.black12,
                offset: Offset(0, 1)),
          ],
          // border: Border.all(width: 1, color: AppColors.logoDarkBlue),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // margin: EdgeInsets.only(right: 10),
              width: 110,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8),
                // border: Border.all(width: 1.5, color: AppColors.logoDarkBlue),
                image: DecorationImage(
                    image: NetworkImage('${getArrFollowUpModel.imageUrl}'),
                    fit: BoxFit.cover),
              ),

              // child: Image.network(''),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${getArrFollowUpModel.reason}',
                  style: theme.labelMedium!.copyWith(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${getArrFollowUpModel.solvingStatus}',
                  style: theme.labelMedium!.copyWith(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${getArrFollowUpModel.clientCommitment}',
                  style: theme.labelMedium!.copyWith(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${getArrFollowUpModel.status}',
                  style: theme.labelMedium!.copyWith(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${getArrFollowUpModel.type}',
                  style: theme.labelMedium!.copyWith(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  FormatDate.investmentDate(
                      "${getArrFollowUpModel.createddate}"),
                  style: theme.labelMedium!.copyWith(fontSize: 12),
                ),
              ],
            ),
            Text(
              '',
              style: theme.labelMedium!.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
