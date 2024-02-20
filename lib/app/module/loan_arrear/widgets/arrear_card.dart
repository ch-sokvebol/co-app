import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:chokchey_finance/app/utils/helpers/format_date.dart';
import 'package:chokchey_finance/localizations/appLocalizations.dart';
import 'package:flutter/material.dart';

class CustomArrearCard extends StatelessWidget {
  final String? name;
  final num? amount;
  final String? paymentDate;
  final num? parAmount;
  final GestureTapCallback? onTapCard;
  final String? currencyCode;
  final String? loanID;
  final GestureTapCallback? onLoanFollowUp;
  final String? empName;
  final GestureTapCallback? onTabHistory;
  const CustomArrearCard(
      {super.key,
      this.name,
      this.amount,
      this.paymentDate,
      this.parAmount,
      this.onTapCard,
      this.currencyCode,
      this.loanID,
      this.onLoanFollowUp,
      this.empName,
      this.onTabHistory});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        padding: EdgeInsets.only(bottom: 10, top: 10, right: 5),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.logoDarkBlue),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Text(
                      '$name',
                      style: theme.bodyLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.logoDarkBlue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Text(
                      '${AppLocalizations.of(context)!.translate('overdue_amt')}: $currencyCode $amount',
                      style: theme.bodySmall!.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.logoDarkBlue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Text(
                      parAmount == 1.0
                          ? '${AppLocalizations.of(context)!.translate('overdue_day')}: ${FormatDate.formatDigit(parAmount ?? 0)} ${AppLocalizations.of(context)!.translate('day')}'
                          : '${AppLocalizations.of(context)!.translate('overdue_day')}: ${FormatDate.formatDigit(parAmount ?? 0)} ${AppLocalizations.of(context)!.translate('days')}',
                      style: theme.bodySmall!.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.logoDarkBlue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Text(
                      '${AppLocalizations.of(context)!.translate('repay_date')}:  ${FormatDate.investmentDate('$paymentDate')}',
                      style: theme.bodySmall!.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.logoDarkBlue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Text(
                      '${AppLocalizations.of(context)!.translate('co_name')}: $empName',
                      style: theme.bodySmall!.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.logoDarkBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Row(
                  //   children: [
                  // Text(
                  //   'Branch: ',
                  //   style: theme.bodyLarge!.copyWith(
                  //       fontSize: 16,
                  //       color: AppColors.logoDarkBlue,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  Text(
                    '$loanID',
                    style: theme.bodyLarge!.copyWith(
                        fontSize: 9,
                        color: AppColors.logoDarkBlue,
                        fontWeight: FontWeight.w500),
                  ),
                  // ],
                  // ),
                  GestureDetector(
                    onTap: onTabHistory,
                    child: Container(
                      margin: const EdgeInsets.only(top: 25, left: 20),
                      padding:
                          AppLocalizations.of(context)!.locale.languageCode ==
                                  'km'
                              ? const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15)
                              : const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.logoDarkBlue),
                      child: Text(
                        '${AppLocalizations.of(context)!.translate('history')}',

                        // ('Par $parAmount Days'),
                        style: theme.bodySmall!.copyWith(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onLoanFollowUp,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, left: 20),
                      padding:
                          AppLocalizations.of(context)!.locale.languageCode ==
                                  'km'
                              ? const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 18)
                              : const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 11),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.logoDarkBlue),
                      child: Text(
                        '${AppLocalizations.of(context)!.translate('follow_up')}',

                        // ('Par $parAmount Days'),
                        style: theme.bodySmall!.copyWith(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
