import 'package:chokchey_finance/app/module/memo_policy/screen/detail_screen.dart';
import 'package:flutter/material.dart';

class CustomMemoPolicyCard extends StatelessWidget {
  const CustomMemoPolicyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMemoSceen(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HR & Admin Department',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, bottom: 4, top: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Memo: 13"),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, bottom: 4, top: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Policy: 13"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
