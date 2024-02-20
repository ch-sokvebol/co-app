import 'package:chokchey_finance/app/module/memo_policy/custom/custom_list_memo_cart.dart';

import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'sf_pdf_screen.dart';

class DetailMemoSceen extends StatefulWidget {
  const DetailMemoSceen({super.key});

  @override
  State<DetailMemoSceen> createState() => _DetailMemoSceenState();
}

class _DetailMemoSceenState extends State<DetailMemoSceen> {
  @override
  void initState() {
    super.initState();
  }

  DateTime? todate;
  DateTime? fromdate;
  TabController? tabController;
  List<String> listtab = ['App', 'Memo', 'Policy'];
  int? index = 0;
  String pathPDF = "";
  final List<String> itemsDepartment = [
    '* HR & Admin Department',
    '* Operation Department',
    '* Product Department',
    '* Credit Rist Department',
    '* Finance Department',
    '* Planing Department',
    '* IT Department',
    '* Marketing Department'
  ];
  final List<String> itemsMemoPolicy = [
    '* Memo',
    '* Policy',
  ];
  String? selectedValueDep;
  String? selectedValureMP;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: logolightGreen,
        title: Text(
          'HR & Admin Department',
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
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Department*'),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: logolightGreen,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Department',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              items: itemsDepartment
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              value: selectedValueDep,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValueDep = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Memo/Policy'),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: logolightGreen,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'All Memo/Policy',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              items: itemsMemoPolicy
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              value: selectedValureMP,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValureMP = value;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('From Date'),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final date = await showDatePickerDialog(
                            context: context,
                            splashColor: Colors.white,
                            highlightColor: Colors.white,
                            initialDate: DateTime.now(),
                            currentDateColor: logolightGreen,
                            daysNameTextStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            enabledCellTextStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                            leadingDateTextStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            disbaledCellColor: Colors.white,
                            minDate: DateTime(2000, 1, 1),
                            maxDate: DateTime(2040, 12, 31),
                          );
                          setState(() {
                            fromdate = date;
                          });
                          debugPrint(
                              'From date --> ${DateFormat('yyyy-MM-dd').format(date!)}');
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: logolightGreen,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${fromdate == null ? 'Effective date' : DateFormat('yyyy-MM-dd').format(fromdate!)}',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('To Date'),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final date = await showDatePickerDialog(
                            context: context,
                            splashColor: Colors.white,
                            highlightColor: Colors.white,
                            initialDate: DateTime.now(),
                            currentDateColor: logolightGreen,
                            daysNameTextStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            enabledCellTextStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                            leadingDateTextStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            disbaledCellColor: Colors.white,
                            minDate: DateTime(2000, 1, 1),
                            maxDate: DateTime(2040, 12, 31),
                          );
                          setState(() {
                            todate = date;
                          });
                          debugPrint(
                              'To date --> ${DateFormat('yyyy-MM-dd').format(date!)}');
                        },
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: logolightGreen,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${todate == null ? 'Effective date' : DateFormat('yyyy-MM-dd').format(todate!)}',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: logolightGreen)),
              child: TextFormField(
                cursorHeight: 18,
                cursorColor: Colors.black,
                initialValue: '',
                decoration: InputDecoration(
                    hintText: 'Input policy/memo title',
                    border: InputBorder.none),
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Row(
            //   children: listtab
            //       .asMap()
            //       .entries
            //       .map((e) => CustomTapBar(
            //             title: e.value,
            //             index: index,
            //             selete: e.key,
            //             ontap: () {
            //               setState(() {
            //                 index = e.key;
            //               });
            //             },
            //           ))
            //       .toList(),
            // ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomListCartMemo(
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SfPdfViewerScreen(),
                        ),
                      );
                    },
                  ),
                  CustomListCartMemo(ontap: () {}),
                  CustomListCartMemo(ontap: () {}),
                  CustomListCartMemo(ontap: () {}),
                  CustomListCartMemo(ontap: () {}),
                  CustomListCartMemo(ontap: () {}),
                  CustomListCartMemo(ontap: () {}),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
