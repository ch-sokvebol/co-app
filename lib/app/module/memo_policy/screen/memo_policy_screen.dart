import 'package:chokchey_finance/app/module/memo_policy/custom/custom_memo_card.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';

class MemoPolicyScreen extends StatelessWidget {
  const MemoPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logolightGreen,
        title: Text(
          'Memo & Policy',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CustomMemoPolicyCard(),
            CustomMemoPolicyCard(),
            CustomMemoPolicyCard(),
            CustomMemoPolicyCard(),
            CustomMemoPolicyCard(),
            CustomMemoPolicyCard(),
            CustomMemoPolicyCard(),
          ],
        ),
      ),
    );
  }
}
