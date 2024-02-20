// ignore_for_file: deprecated_member_use

import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNotification extends StatelessWidget {
  const CustomNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: logoDarkBlue,
        title: Text("Custom Notificaton"),
        leading: BackButton(),
      ),
      body: Container(
        height: 90,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: logoDarkBlue,
          ),
        ),
        child: Row(children: [
          SvgPicture.asset(
            'assets/svg/bell.svg',
            color: logoDarkBlue,
            height: 46,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Vorn Phanmal | CO-SMC",
                    style: TextStyle(
                      fontSize: 12,
                      color: logoDarkBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "02-May-2023/09:20AM",
                    style: TextStyle(
                      fontSize: 10,
                      color: Color.fromARGB(255, 92, 160, 228),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "New Loan has been assigns for reveiw :",
                style: TextStyle(
                  fontSize: 10,
                  color: Color.fromARGB(255, 19, 92, 165),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "  - Customer: Sey Ha",
                style: TextStyle(
                  fontSize: 10,
                  color: Color.fromARGB(255, 19, 92, 165),
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "  - Amount : USD 10,000",
                style: TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 19, 92, 165),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
