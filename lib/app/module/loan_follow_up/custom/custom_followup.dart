import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';

class CustomFollowUp extends StatelessWidget {
  const CustomFollowUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 150,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1.2,
          color: logoDarkBlue,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer Name",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: logoDarkBlue,
                ),
              ),
              Spacer(),
              Text(
                "Loan ID: 00000001",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: logoDarkBlue,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Amount : USD \$10,000",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: logoDarkBlue,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Date : 01,May,2023",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: logoDarkBlue,
            ),
          ),
          Row(
            children: [
              Text(
                "Branch : SMC",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: logoDarkBlue,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      EdgeInsets.only(left: 13, right: 13, bottom: 10, top: 10),
                  decoration: BoxDecoration(
                    color: logoDarkBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Follow Up",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
          Text(
            "CO : IT",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: logoDarkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
