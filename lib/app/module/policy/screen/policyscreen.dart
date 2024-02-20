import 'package:chokchey_finance/app/module/loan_resistration/custom/custom_registration.dart';
import 'package:chokchey_finance/app/module/policy/custom/custom_card.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';

class PolicysScreen extends StatelessWidget {
  const PolicysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: logolightGreen,
        leading: BackButton(),
        title: Text(
          "Policy",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomCardPolicy(
              text: "CCF Flutter",
              onTap: () {},
            ),
            CustomCardPolicy(
              text: "CCF PDF",
              onTap: () {
                debugPrint("CCF");
              },
            ),
            CustomLoadRegistration(
              onTap: () {
                debugPrint("1234567");
              },
              title: '1234',
              icon: Icons.abc,
            ),
          ],
        ),
      ),
    );
  }
}
