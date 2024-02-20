import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';

import '../../../../localizations/appLocalizations.dart';

class NoticeNewsScreen extends StatelessWidget {
  const NoticeNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
        backgroundColor: logolightGreen,
        title: Text(
          '${AppLocalizations.of(context)!.translate('notice')} & ${AppLocalizations.of(context)!.translate('news')}',
          // 'Notice & News',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        //do example it for me
        // child: CustomCartPar(),
        child: Center(
          child: Text(
            "${AppLocalizations.of(context)!.translate('no_data')}",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
