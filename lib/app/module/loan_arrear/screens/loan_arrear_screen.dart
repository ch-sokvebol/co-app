import 'dart:io';

import 'package:chokchey_finance/app/module/loan_arrear/controllers/loan_arrear_controller.dart';
import 'package:chokchey_finance/app/module/loan_arrear/screens/All_par_screen.dart';
import 'package:chokchey_finance/app/module/loan_arrear/screens/par_five_screen.dart';
import 'package:chokchey_finance/app/module/loan_arrear/screens/par_four_screen.dart';
import 'package:chokchey_finance/app/module/loan_arrear/screens/par_larger_one_screen.dart';
import 'package:chokchey_finance/app/module/loan_arrear/screens/par_second_screen.dart';
import 'package:chokchey_finance/app/module/loan_arrear/screens/par_thirt_screen.dart';
import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:chokchey_finance/app/utils/helpers/custom_drop_down.dart';
import 'package:chokchey_finance/app/widgets/custom_app_bar.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:chokchey_finance/utils/storages/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../localizations/appLocalizations.dart';
import '../../../utils/helpers/dropdow_item.dart';
import '../../search_employee/custom/custom_buttomsheet.dart';
import '../../util/widget/custom_textfield.dart';

class LoanArrearScreens extends StatefulWidget {
  final int? indexOfpage;
  final bool? isFromPar;
  const LoanArrearScreens(
      {super.key, this.indexOfpage, this.isFromPar = false});

  @override
  State<LoanArrearScreens> createState() => _LoanArrearScreensState();
}

class _LoanArrearScreensState extends State<LoanArrearScreens>
    with SingleTickerProviderStateMixin {
  final con = Get.put(LoanArrearController());
  // final controllerSearchCo = Get.put(SearchCOController());
  TabController? _tabController;
  String? typeUser = '';
  String? empCode = '';
  _onType(String? typeUsers) async {
    typeUsers = await storage.read(key: 'user_type');
    empCode = await storage.read(key: 'user_id');
    setState(() {
      typeUser = typeUsers;
    });
  }

  final currentDate = DateTime.now();
  var date;
  // bool? tabfilter = false;
  onSelectpar() {
    if (widget.isFromPar == true) {
      if (widget.indexOfpage == 1) {
        _tabController!.index = 1;
      } else if (widget.indexOfpage == 2) {
        _tabController!.index = 2;
      } else if (widget.indexOfpage == 3) {
        _tabController!.index = 3;
      } else if (widget.indexOfpage == 4) {
        _tabController!.index = 4;
      } else {
        _tabController!.index = 5;
      }
    }
  }

  @override
  void initState() {
    _onType(typeUser);

    setState(() {});

    _tabController = TabController(vsync: this, length: 6);

    con.searchAllCO('');
    con.update();
    con.getBrance();
    con.onFilterArrear();
    date = DateFormat("yyyyMMdd").format(
        DateTime(currentDate.year, currentDate.month, currentDate.day - 1));

    onSelectpar();
    con.searchAllCO('');
    con.getOption();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return CupertinoScaffold(
      body: Builder(builder: (context) {
        return Scaffold(
          appBar: CustomAppBar(
            centerTitle: true,
            context: context,
            title:
                '${AppLocalizations.of(context)!.translate('loan_arrear') ?? 'Loan Arrears'}',
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Platform.isAndroid
                  ? Icon(
                      Icons.arrow_back,
                    )
                  : Icon(
                      Icons.arrow_back_ios,
                    ),
            ),
            action: [
              typeUser == "CO"
                  ? Container()
                  : Builder(
                      builder: (context) => IconButton(
                        icon: Icon(Icons.filter_list),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                          con.txtUserCodeCopy.value = '';
                          con.txtBranceCopy.value = '';
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      ),
                    ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.logolightGreen,
                  ),
                  child: TabBar(
                    indicatorColor: AppColors.logoDarkBlue,
                    indicatorWeight: 2.0,
                    controller: _tabController,
                    unselectedLabelColor: Colors.white,
                    labelColor: AppColors.logoDarkBlue,
                    labelPadding: const EdgeInsets.only(bottom: 10, top: 13),
                    indicatorPadding: EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    tabs: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            ' All',
                            style:
                                TextStyle(fontFamily: 'DMSans', fontSize: 14),
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'P >1',
                            style:
                                TextStyle(fontFamily: 'DMSans', fontSize: 14),
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'P >14',
                            style:
                                TextStyle(fontFamily: 'DMSans', fontSize: 14),
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'P >30',
                            style:
                                TextStyle(fontFamily: 'DMSans', fontSize: 14),
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'P >60',
                            style:
                                TextStyle(fontFamily: 'DMSans', fontSize: 14),
                          ),
                          Container(
                            // margin: EdgeInsets.only(left: 10),
                            width: 1,
                            height: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Text(
                        'P >90',
                        style: TextStyle(fontFamily: 'DMSans', fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      AllParScreen(
                          // allArrear: con.arrearModel.value,
                          ),
                      ParLargerOneScreen(),
                      ParsecondScreen(),
                      ParThirtScreen(),
                      ParFourScreen(),
                      ParFiveScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          endDrawer: Obx(
            () => Drawer(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 40)),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 10, top: 20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.sort,
                              color: AppColors.logolightGreen,
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 5, left: 5)),
                            Text(
                              "${AppLocalizations.of(context)!.translate('filter')}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  color: AppColors.logolightGreen),
                            )
                          ],
                        ),
                      ),

                      typeUser == "BM"
                          ? Container()
                          : Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 10, top: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.menu,
                                    color: AppColors.logolightGreen,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: Text(
                                      "${AppLocalizations.of(context)!.translate('search_branch') ?? 'Search by Branch'} ",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      typeUser == "BM"
                          ? Container()
                          : con.txtUserName.value != ''
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('search_branch') ?? 'Search Branch Name'}',
                                        style: theme.labelMedium!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                )
                              : typeUser == "BM"
                                  ? Container()
                                  : CustomDropDown(
                                      isSearchButton: false,
                                      label:
                                          '${AppLocalizations.of(context)!.translate('branch_name') ?? 'Branch Name'}',
                                      item: con.branceList
                                          .asMap()
                                          .entries
                                          .map((e) {
                                        return DropDownItem(
                                          itemList: {
                                            "Name": "${e.value.bname}",
                                            "title": e.value.bcode,
                                          },
                                        );
                                      }).toList(),
                                      onChange: (e) {
                                        con.txtBranceName.value = e['Name'];
                                        con.txtBranceCopy.value = e['title'];
                                        con.txtUserName.value = '';
                                      },
                                      defaultValue: con.txtBranceName.value !=
                                              ''
                                          ? {
                                              "Name": con.txtBranceName.value,
                                              // "title": con.userModel.value.uid,
                                            }
                                          : null,
                                      onChangeSearch: (a) async {
                                        setState(() {
                                          con.searchAllCO(
                                            a,
                                          );
                                        });
                                      },
                                    ),

                      typeUser == "BM"
                          ? Container()
                          : Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 15.0),
                                      child: Divider(
                                        color: Colors.black,
                                        height: 50,
                                      )),
                                ),
                                Text(
                                  '${AppLocalizations.of(context)!.translate('or')}',
                                  style: TextStyle(
                                      color: AppColors.logolightGreen),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 15.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: AppColors.logolightGreen,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                '${AppLocalizations.of(context)!.translate('search_employee') ?? "Search by CO"}',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      con.txtBranceName.value != ''
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              margin: EdgeInsets.only(left: 20, right: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.translate('search_employee')}',
                                    style: theme.labelMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            )
                          //     : Container(
                          //         // padding: EdgeInsets.only(left: 10, right: 10),
                          //         child: Obx(
                          //           () => CustomDropDown(
                          //             onLeading: () {
                          //               Navigator.pop(context);
                          //               // con.userLists.clear();
                          //             },
                          //             hintSearch: 'Search Employee Name',
                          //             isSearchButton: true,
                          //             isSearchUserStatic: true,
                          //             label:
                          //                 '${AppLocalizations.of(context)!.translate('employee_name') ?? 'Employee Name'}',
                          //             isLoandingItem:
                          //                 con.isLoadinguser.value == true,
                          //             item: [
                          //               ...con.userLists.map((e) {
                          //                 return DropDownItem(
                          //                   itemList: {
                          //                     "Name": "${e.uname}",
                          //                     "title": e.uid,
                          //                   },
                          //                 );
                          //               }).toList()
                          //             ],
                          //             onChange: (e) {
                          //               if (e.isNotEmpty) {
                          //                 con.txtUserName.value = e['Name'];
                          //                 con.txtUserCodeCopy.value = e['title'];
                          //               } else {
                          //                 con.txtUserName.value = '';
                          //               }
                          //             },
                          //             defaultValue: con.txtUserName.value != ''
                          //                 ? {
                          //                     "Name": con.txtUserName.value,
                          //                   }
                          //                 : null,
                          //             onChangeSearch: (String a) {
                          //               // setState(() {
                          //               //   Future.delayed(Duration(seconds: 3), () {
                          //               //     con.searchAllCO(searchusername: a);
                          //               //     con.update();
                          //               //   });
                          //               // });

                          //               Future.delayed(Duration(seconds: 1), () {
                          //                 // con.onSearchText(a);
                          //                 con.searchAllCO(searchusername: a);
                          //                 con.update(con.userLists);
                          //               });
                          //               setState(() {});
                          //             },
                          //           ),
                          //         ),
                          //       ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          : GestureDetector(
                              onTap: () {
                                con.searchAllCO('');
                                onCustomShowBottomSheet(
                                  title: AppLocalizations.of(context)!
                                      .translate('search_employee'),
                                  then: () {},
                                  ontab: () {},
                                  appbar: true,
                                  context: context,
                                  stack: Container(
                                    padding: const EdgeInsets.only(
                                        right: 20, top: 15, left: 20),
                                    child: CustomTextFieldNew(
                                      labelText: AppLocalizations.of(context)!
                                          .translate('search_employee'),
                                      hintText: AppLocalizations.of(context)!
                                          .translate('search_employee'),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: AppColors.logoDarkBlue,
                                      ),
                                      borderColor: AppColors.logoDarkBlue
                                          .withOpacity(0.4),
                                      onChange: (e) {
                                        con.searchAllCO(e.toLowerCase());
                                        con.update(con.userLists);
                                      },
                                      hinTextColor: Colors.black54,
                                    ),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 30),
                                    child: SingleChildScrollView(
                                      child: Container(
                                        child: Obx(
                                          () => con.isLoadinguser.value == true
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 50),
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color: logolightGreen,
                                                  )),
                                                )
                                              : con.userLists.length == 0
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 50),
                                                      child: Center(
                                                        child: Text(
                                                          "No Employee Name",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                      ),
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: con.userLists
                                                          .asMap()
                                                          .entries
                                                          .map((e) =>
                                                              GestureDetector(
                                                                onTap: () {
                                                                  // controllerSearchCo
                                                                  //     .isSelect
                                                                  //     .value = true;
                                                                  con.txtUserName
                                                                          .value =
                                                                      e.value
                                                                          .uname!;
                                                                  con.txtUserCodeCopy
                                                                          .value =
                                                                      e.value
                                                                          .uid
                                                                          .toString();
                                                                  con.txtBranceCopy
                                                                      .value = '';
                                                                  // debugPrint(
                                                                  //     "ontap name :${controllerSearchCo.isSelect.value}");
                                                                  // debugPrint(
                                                                  //     "ontap name :${e.value.uname}");
                                                                  // debugPrint(
                                                                  //     "ontap id :${e.value.uid}");
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  //  height: 80,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 20,
                                                                    right: 20,
                                                                    top: 10,
                                                                  ),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        '${e.value.uname}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            6,
                                                                      ),
                                                                      Text(
                                                                        '${e.value.ucode}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            6,
                                                                      ),
                                                                      Divider(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.3),
                                                                        thickness:
                                                                            1,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ))
                                                          .toList(),
                                                    ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: 1.8,
                                    color: AppColors.logoDarkBlue,
                                  ),
                                ),
                                child: Row(children: [
                                  con.txtUserName.value != ''
                                      ? Text(
                                          '${con.txtUserName.value}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        )
                                      : Text(
                                          '${AppLocalizations.of(context)!.translate('employee_name')}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(color: Colors.black45),
                                        ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                ]),
                              ),
                            ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 120,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.logoDarkBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                // bcode = "";
                                // selectedEmployeeID = "";
                                // fetchLoanArrear();
                                Navigator.pop(context);
                                con.txtBranceName.value = '';
                                // con.txtUserName.value = '';
                                con.txtUserName.value = '';
                                // con.txtBranceCopy.value = '';
                                // con.txtUserCodeCopy.value = '';
                              },
                              child: Text(
                                '${AppLocalizations.of(context)!.translate('clear')}',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 30),
                            width: 120,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.logolightGreen,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () async {
                                if (con.ontapFilter.value = true) {
                                  _tabController!.index = 0;
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (BuildContext context) =>
                                  //             AllParScreen()));
                                  // AllParScreen();
                                }

                                await con
                                    .onfilterArrearNew(
                                  overDueday: 0,
                                  baseDate: date,
                                  branchCode: con.txtBranceCopy.value,
                                  employeeCode: con.txtUserCodeCopy.value,
                                )
                                    .then((value) {
                                  Navigator.pop(context);
                                  con.txtBranceName.value = '';
                                  // con.txtUserName.value = '';
                                  con.txtUserName.value = '';
                                  // con.txtBranceCopy.value = '';
                                  // con.txtUserCodeCopy.value = '';
                                  // _tabController!.previousIndex;
                                });
                                // onFilter();
                                // onFilterByCO();
                              },
                              child: con.isLoadingFilterNew.value == true
                                  ? SpinKitThreeBounce(
                                      color: Colors.white,
                                      // type: SpinKitWaveType.start,
                                      size: 20,
                                    )
                                  : Text(
                                      "${AppLocalizations.of(context)!.translate('apply')}",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                            ),
                          ),
                        ],
                      )
                      // SizedBox(

                      // child: ListView.builder(
                      //   physics: NeverScrollableScrollPhysics(),
                      //   itemCount: listBranch.length,
                      //   padding: EdgeInsets.only(top: 15.0),
                      //   itemBuilder: (context, index) {
                      //     return Card(
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //           side: BorderSide(
                      //               color: AppColors.logolightGreen, width: 1)),
                      //       child: InkWell(
                      //         onTap: () => _onClickListBranch(listBranch[index]),
                      //         child: Center(
                      //           child: Container(
                      //             padding: EdgeInsets.all(8),
                      //             child: Text(
                      //               '${listBranch[index]['bname']}',
                      //               style: TextStyle(
                      //                 fontSize: 17,
                      //                 color: bcode == listBranch[index]['bcode']
                      //                     ? AppColors.logolightGreen
                      //                     : Colors.black,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
