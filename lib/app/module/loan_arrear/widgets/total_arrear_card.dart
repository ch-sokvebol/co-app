import 'package:flutter/material.dart';

import '../../../utils/helpers/format_convert.dart';

class TotalArrearCard extends StatelessWidget {
  final int? totalAccount;
  final double? overdueUSD, overdueKH;
  const TotalArrearCard(
      {super.key, this.totalAccount, this.overdueUSD, this.overdueKH});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      // padding: EdgeInsets.symmetric(
      //   vertical: 15,
      // ),
      width: double.infinity,
      // height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 5, spreadRadius: 3, color: Colors.grey[200]!)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Text(
                  'Total Account',
                  style: theme.labelLarge!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("${totalAccount ?? 0}",
                    style: theme.titleSmall!.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 18)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      'Overdue USD',
                      style: theme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${FormatConvert.formatCurrency(overdueUSD!) ?? 0.0} \$',
                      style: theme.titleSmall!.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Overdue KHR',
                      style: theme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Text(
                      '${FormatConvert.formatCurrency(overdueKH!) ?? 0.0} ៛',
                      style: theme.titleSmall!.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
