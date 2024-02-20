import 'package:chokchey_finance/app/module/loan_arrear/models/Get_arr_follow_up_model.dart';
import 'package:chokchey_finance/app/utils/helpers/format_date.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../utils/helpers/format_convert.dart';
import '../../../widgets/custom_app_bar.dart';

class ReportArrFollowUpDetail extends StatefulWidget {
  final num? idDetail;
  final GetArrFollowUpModel? getArrear;
  const ReportArrFollowUpDetail({super.key, this.idDetail, this.getArrear});

  @override
  State<ReportArrFollowUpDetail> createState() =>
      _ReportArrFollowUpDetailState();
}

class _ReportArrFollowUpDetailState extends State<ReportArrFollowUpDetail> {
  ExpandableController? expandableController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      // backgroundColor: AppColors.logolightGreen,
      appBar: CustomAppBar(
        context: context,
        title: 'Arrear Follow-Up Detail',
        centerTitle: true,
        elevation: 0,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBox) {
          return [
            SliverAppBar(
              shadowColor: Colors.transparent,
              // floating: true,
              pinned: true,
              automaticallyImplyLeading: false,
              expandedHeight: 210,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  // color: Colors.transparent,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage('${widget.getArrear!.imageUrl}'),
                        fit: BoxFit.cover),
                  ),
                  //     ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                padding: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black12),
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(10),
                  //   topRight: Radius.circular(10),
                  // ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Loan Balance',
                                style: theme.displaySmall!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87)),
                            SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text:
                                    '${FormatConvert.formatCurrency(double.parse('${widget.getArrear!.loanBalance}'))}',

                                ///${widget.getArrear!.currencyCode}
                                style: theme.displaySmall!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red),
                                children: [
                                  TextSpan(
                                    text: ' USD',
                                    style: theme.displaySmall!.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.2,
                      color: Colors.black12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 15, left: 20, right: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create Date',
                                  style: theme.titleMedium!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  FormatDate.formatDateTime(
                                      '${widget.getArrear!.createddate}'),
                                  style:
                                      theme.titleMedium!.copyWith(fontSize: 16),
                                ),
                              ]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create By',
                                style: theme.titleMedium!.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${widget.getArrear!.createdby}",
                                style:
                                    theme.titleMedium!.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Reason: ',
                                style: theme.titleMedium!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Lost Job',
                                    style: theme.titleMedium!.copyWith(
                                      fontSize: 14,
                                    ),
                                  )
                                ]),
                          ),
                          if (widget.getArrear!.reason!.toLowerCase() ==
                                  'Lost job'.toLowerCase() ||
                              widget.getArrear!.reason!.toLowerCase() ==
                                  'Fail in business'.toLowerCase())
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'o ',
                                        style: theme.titleMedium!.copyWith(
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Job Name: ',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${widget.getArrear!.jobName}',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'o ',
                                        style: theme.titleMedium!.copyWith(
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Work Place: ',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${widget.getArrear!.workPlace}',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Solving Status: ',
                                style: theme.titleMedium!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${widget.getArrear!.solvingStatus}',
                                    style: theme.titleMedium!.copyWith(
                                      fontSize: 14,
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Client Commitment: ',
                                style: theme.titleMedium!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '${widget.getArrear!.clientCommitment}',
                                    style: theme.titleMedium!.copyWith(
                                      fontSize: 14,
                                    ),
                                  )
                                ]),
                          ),
                          if (widget.getArrear!.clientCommitment!
                                      .toLowerCase() ==
                                  'Pay full amount'.toLowerCase() ||
                              widget.getArrear!.clientCommitment!
                                      .toLowerCase() ==
                                  'Pay partial amount'.toLowerCase())
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'o ',
                                        style: theme.titleMedium!.copyWith(
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Pay Date: ',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${widget.getArrear!.clientPayDate}',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'o ',
                                      style: theme.titleMedium!.copyWith(
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Pay Amount: ',
                                          style: theme.titleMedium!.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${FormatConvert.formatCurrencyNew(widget.getArrear!.clientPayAmt!)}\$',
                                          style: theme.titleMedium!.copyWith(
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (widget.getArrear!.clientCommitment!
                                  .toLowerCase() ==
                              'Client agreed to do revolving loan'
                                  .toLowerCase())
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'o ',
                                        style: theme.titleMedium!.copyWith(
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Do Revolving Date: ',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${widget.getArrear!.revolvingDate}',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'o ',
                                        style: theme.titleMedium!.copyWith(
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Disbursement Date: ',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${widget.getArrear!.disburseDate}',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          if (widget.getArrear!.clientCommitment!
                                  .toLowerCase() ==
                              'Client agrees to sell collateral'.toLowerCase())
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'o ',
                                        style: theme.titleMedium!.copyWith(
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Sell Date: ',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${widget.getArrear!.sellDate}',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'o ',
                                        style: theme.titleMedium!.copyWith(
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Sell Amount: ',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${FormatConvert.formatCurrencyNew(widget.getArrear!.sellAmt!)}\$',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Status: ',
                                style: theme.titleMedium!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${widget.getArrear!.status}',
                                    style: theme.titleMedium!.copyWith(
                                      fontSize: 14,
                                    ),
                                  )
                                ]),
                          ),
                          if (widget.getArrear!.status ==
                              'Completed for partial amount')
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'o ',
                                        style: theme.titleMedium!.copyWith(
                                          fontSize: 14,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Pay Date: ',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${widget.getArrear!.clientPayDate}',
                                            style: theme.titleMedium!.copyWith(
                                              fontSize: 14,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'o ',
                                      style: theme.titleMedium!.copyWith(
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Pay Amount: ',
                                          style: theme.titleMedium!.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${FormatConvert.formatCurrencyNew(widget.getArrear!.clientPayAmt!)}\$',
                                          style: theme.titleMedium!.copyWith(
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Type: ',
                                style: theme.titleMedium!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${widget.getArrear!.type}',
                                    style: theme.titleMedium!.copyWith(
                                      fontSize: 14,
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (widget.getArrear!.remark != '')
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Remark: ',
                                  style: theme.titleMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${widget.getArrear!.remark}',
                                      style: theme.titleMedium!.copyWith(
                                        fontSize: 14,
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Column(
      //   children: [
      //     Container(
      //       width: double.infinity,
      //       // margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      //       height: 200,
      //       decoration: BoxDecoration(
      //           // borderRadius: BorderRadius.circular(20),
      //           image: DecorationImage(
      //               image: NetworkImage('${widget.getArrear!.imageUrl}'),
      //               fit: BoxFit.cover)),
      //     ),
      //     Container(
      //       margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      //       width: double.infinity,
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           boxShadow: [
      //             BoxShadow(
      //               blurRadius: 5,
      //               spreadRadius: 3,
      //               color: Colors.black12,
      //             ),
      //           ],
      //           color: Colors.white),
      //       child: Column(children: [
      //         Container(
      //           margin: EdgeInsets.only(top: 20),
      //           width: double.infinity,
      //           height: 80,
      //           color: AppColors.logoPink,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      //           child: Row(
      //             children: [
      //               RichText(
      //                 text: TextSpan(
      //                   text: '${widget.getArrear!.reason}',
      //                   style: theme.titleMedium!.copyWith(fontSize: 16),
      //                   children: [
      //                     TextSpan(text: '.${widget.getArrear!.jobName}'),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ]),
      //     ),
      //   ],
      // ),
    );
  }
}
