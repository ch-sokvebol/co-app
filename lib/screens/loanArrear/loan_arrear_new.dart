import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoanArrearNew extends StatelessWidget {
  const LoanArrearNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.4,
        backgroundColor: logolightGreen,
        title: Text(
          'Laon Arrears',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(Icons.menu),
        actions: [
          SvgPicture.asset('assets/svg/search.svg'),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.filter_list,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: logolightGreen),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "All",
                      style: TextStyle(
                        fontSize: 16,
                        color: logoDarkBlue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 1.4,
                      color: Colors.white,
                    ),
                    Text(
                      "PAR>14",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 1.4,
                      color: Colors.white,
                    ),
                    Text(
                      "PAR>30",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 1.4,
                      color: Colors.white,
                    ),
                    Text(
                      "PAR>60",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1.4,
                    color: logoDarkBlue,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1.4,
                    color: logoDarkBlue,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1.4,
                    color: logoDarkBlue,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1.4,
                    color: logoDarkBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 10),
        height: 90,
        color: logolightGreen,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              'assets/svg/home.svg',
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                // setState(
                //   () {
                //     isSelect = !isSelect!;
                //     // debugPrint("===> $isSelect");
                //   },
                // );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: logolightGreen,
                  shape: BoxShape.circle,
                  //border: Border.all(width: 1, color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 1),
                      color: Color.fromARGB(255, 112, 110, 110),
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  'assets/svg/plus.svg',
                  height: 40,
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/svg/star.svg',
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
