import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';

class CustomListCartMemo extends StatelessWidget {
  final Function? ontap;
  const CustomListCartMemo({
    super.key,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap!(),
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: ListTile(
          title: Text(
            "Staff movement & Promotion",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text("11-12-2023"),
          trailing: Container(
            padding: EdgeInsets.only(
              top: 4,
              bottom: 4,
              right: 10,
              left: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: logolightGreen,
              ),
            ),
            child: Text("Policy"),
          ),
        ),
      ),
    );
  }
}
