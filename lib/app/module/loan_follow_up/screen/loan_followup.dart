import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';

import '../../../../localizations/appLocalizations.dart';

class LaonFollowUpScren extends StatefulWidget {
  LaonFollowUpScren({super.key});

  @override
  State<LaonFollowUpScren> createState() => _LaonFollowUpScrenState();
}

class _LaonFollowUpScrenState extends State<LaonFollowUpScren>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = logolightGreen;
  //final _unselectedColor = Color(0xff5f6368);
  final _tabs = [
    Tab(text: 'First'),
    Tab(text: 'Second'),
  ];

  // final _iconTabs = [
  //   Tab(icon: Icon(Icons.home)),
  //   Tab(icon: Icon(Icons.search)),
  // ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: logolightGreen,
        elevation: 2,
        centerTitle: true,
        title: Text(
          "${AppLocalizations.of(context)!.translate('loan_follow_up')}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              height: kToolbarHeight - 8.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: _selectedColor),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: _tabs,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Center(
                    child: Text(
                      "${AppLocalizations.of(context)!.translate('no_data')}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  // Column(
                  //   children: [
                  //     CustomFollowUp(),
                  //     CustomFollowUp(),
                  //   ],
                  // ),
                  Center(
                    child: Text(
                      "${AppLocalizations.of(context)!.translate('no_data')}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
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
