// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:chokchey_finance/components/maxWidthWrapper.dart';
import 'package:chokchey_finance/localizations/appLocalizations.dart';
import 'package:chokchey_finance/providers/approvalHistory/index.dart';
import 'package:chokchey_finance/providers/manageService.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:chokchey_finance/utils/storages/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../app/module/home_new/screen/new_homescreen.dart';
import 'detailCustomerRegistration.dart';

class ListCustomerRegistrations extends StatefulWidget {
  @override
  _ListCustomerRegistrationsState createState() =>
      _ListCustomerRegistrationsState();
}

class _ListCustomerRegistrationsState extends State<ListCustomerRegistrations> {
  var parsed = [];
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (mounted) {
      getListCustomer(20, 1, '', '', '', '', '');
      getListBranches();
    }
  }

  onTapsDetail(value) async {
    // Navigator.of(context).push(new MaterialPageRoute<Null>(
    //     builder: (BuildContext context) {
    //       return CardDetailCustomer(
    //         list: value['ccode'],
    //       );
    //     },
    //     fullscreenDialog: true));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailCustomer(
          list: value['ccode'],
        ),
      ),
    );
  }

  ScrollController _scrollController = ScrollController();
  Future getListCustomer(
      _pageSize, _pageNumber, status, code, bcode, sdate, edate) async {
    setState(() {
      _isLoading = true;
    });
    final storage = new FlutterSecureStorage();
    try {
      var token = await storage.read(key: 'user_token');
      var userUcode = await storage.read(key: "user_ucode");
      var branch = await storage.read(key: "branch");
      var level = await storage.read(key: "level");
      var sdates = sdate != null ? sdate : '';
      var edates = edate != null ? edate : '';
      var codes = code != null ? code : '';
      status != null ? status : '';
      var btlcode = status != null ? status : '';
      var bcodes;
      var ucode;
      if (level == '3') {
        bcodes = bcode != null && bcode != "" ? bcode : branch;
        btlcode = '';
        ucode = codes != null && codes != "" ? codes : "";
      }

      if (level == '2') {
        bcodes = bcode != null && bcode != "" ? bcode : branch;
        btlcode = userUcode;
        ucode = code != null && code != "" ? code : '';
      }

      if (level == '1') {
        bcodes = bcode != null && bcode != "" ? bcode : branch;
        ucode = userUcode;
        btlcode = '';
      }

      if (level == '4' || level == '5' || level == '6') {
        bcodes = bcode != null && bcode != "" ? bcode : '';
        btlcode = '';
        ucode = code != null && code != "" ? code : '';
      }
      final Map<String, dynamic> bodyRow = {
        "pageSize": "$_pageSize",
        "pageNumber": "$_pageNumber",
        "ucode": "$ucode",
        "bcode": "$bcodes",
        "btlcode": "$btlcode",
        "status": "",
        "code": "",
        "sdate": "$sdates",
        "edate": "$edates"
      };
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Response response = await api().post(
          Uri.parse(baseURLInternal + 'customers/all'),
          headers: headers,
          body: json.encode(bodyRow));
      if (response.statusCode == 200) {
        var listLoan = jsonDecode(response.body);
        setState(() {
          parsed = listLoan[0]['listCustomers'];
          _isLoading = false;
        });
        return listLoan;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('error::: $error');
    }
  }

  var listBranch = [];
  var listCO = [];
  var status;
  var code;
  var sdate;
  var edate;
  var bcode;
  final profile = const AssetImage('assets/images/profile_create.jpg');

  void _closeEndDrawer() {
    setState(() {
      code = null;
      bcode = null;
      controllerEndDate.text = '';
      controllerStartDate.text = '';
      _isLoading = true;
    });
    getListCustomer(20, 1, '', '', '', '', '')
        .then((value) => {
              setState(() {
                _isLoading = false;
              })
            })
        .catchError(
      (onError) {
        setState(
          () {
            _isLoading = false;
          },
        );
        return onError;
      },
    );
    getListBranches();
    Navigator.of(context).pop();
  }

  Future getListBranches() async {
    await ApprovalHistoryProvider()
        .getListBranch()
        .then((value) => {
              setState(() {
                listBranch = value;
              }),
            })
        .catchError((onError) {
      return onError;
    });
  }

  var isHasData = true;

  Future _applyEndDrawer() async {
    setState(() {
      _isLoading = true;
    });
    DateTime now = DateTime.now();
    var startDate = sdate != null ? sdate : DateTime(now.year, now.month, 1);
    var endDate = edate != null ? edate : DateTime.now();
    getListCustomer(20, 1, '', '', bcode, startDate, endDate)
        .then((value) => {
              setState(() {
                _isLoading = false;
              }),
            })
        .catchError((onError) {
      logger().e("error: $onError");
      setState(() {
        _isLoading = false;
      });
      return onError;
    });
    Navigator.of(context).pop();
    setState(() {
      _isLoading = true;
    });
  }

  _onClickListBranch(v) {
    setState(() {
      bcode = v['bcode'];
    });
  }

  TextEditingController controllerStartDate = new TextEditingController();
  TextEditingController controllerEndDate = new TextEditingController();

  Future<void> _getData() async {
    setState(() {
      _isLoading = true;
    });
    getListCustomer(20, 1, '', '', '', '', '')
        .then((value) => {
              setState(() {
                _isLoading = false;
              })
            })
        .catchError((onError) {
      setState(() {
        _isLoading = false;
      });
      return onError;
    });
  }

  Future<bool> _onBackPressed() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => NewHomeScreen()
            // Home()
            ),
        ModalRoute.withName("/Home"));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        appBar: new AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: new Text(
              AppLocalizations.of(context)!.translate('customer_list') ??
                  "Customer List"),
          backgroundColor: logolightGreen,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            //Filter...............
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(
                    color: logolightGreen,
                  ),
                ),
              )
            : parsed.length > 0
                ? RefreshIndicator(
                    onRefresh: _getData,
                    child: MaxWidthWrapper(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: parsed.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.all(5),
                              // padding: EdgeInsets.only(left: 5, right: 5, top: 3),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: logolightGreen, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      onTap: () {
                                        onTapsDetail(parsed[index]);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Image(
                                                    image: profile,
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        '${parsed[index]['namekhr']}',
                                                        style: mainTitleBlack,
                                                      ),
                                                      Text(
                                                          '${parsed[index]['nameeng'] != null ? parsed[index]['nameeng'] : ''}'),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 2)),
                                                      Text(
                                                          '${parsed[index]['ccode']}'),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                        bottom: 2,
                                                      )),
                                                      Text(
                                                          '${parsed[index]['phone1']}'),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 2)),
                                                      Text(
                                                          '${parsed[index]['userName'].substring(9)} - ${parsed[index]['branchName']}'),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 2)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                  bottom: 2,
                                                )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                  top: 5,
                                                )),
                                                Text(
                                                    '${getDateTimeYMD(parsed[index]['rdate'])}'),
                                                Text(''),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 2,
                                                        left: 1,
                                                        bottom: 10))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          }),
                    ),
                  )
                : Center(
                    child: Container(
                      child: Text(
                          AppLocalizations.of(context)!.translate('no_data') ??
                              ""),
                    ),
                  ),

        /// ----EndDrawer
        endDrawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 35)),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Icon(Icons.filter_list),
                        Padding(padding: EdgeInsets.only(right: 5)),
                        Text(
                          'Filter',
                          style: TextStyle(
                              fontWeight: fontWeight800, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      AppLocalizations.of(context)!.translate('list_branch') ??
                          'List Branch',
                      style: TextStyle(
                          // fontWeight: fontWeight700,
                          ),
                    ),
                  ),
                  listBranch.isNotEmpty
                      ? Container(
                          height: 180,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: ListView.builder(
                            itemCount: listBranch.isNotEmpty
                                ? listBranch.length
                                : [].length,
                            padding: const EdgeInsets.only(top: 10.0),
                            itemBuilder: (context, index) {
                              return Card(
                                child: InkWell(
                                  onTap: () {
                                    _onClickListBranch(listBranch[index]);
                                  },
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        '${listBranch[index]['bname']}',
                                        style: TextStyle(
                                            color: bcode ==
                                                    listBranch[index]['bcode']
                                                ? logolightGreen
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Padding(padding: EdgeInsets.only(bottom: 1)),
                  //Pick start date
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: FormBuilderDateTimePicker(
                      name: 'date',
                      controller: controllerStartDate,
                      inputType: InputType.date,
                      onChanged: (v) {
                        setState(() {
                          sdate =
                              v != null ? v : DateTime(now.year, now.month, 1);
                        });
                      },
                      initialValue: DateTime(now.year, now.month, 1),
                      format: DateFormat("yyyy-MM-dd"),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                                .translate('start_date') ??
                            "Start date",
                      ),
                    ),
                  ),
                  //Pick date End
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: FormBuilderDateTimePicker(
                      name: 'date',
                      controller: controllerEndDate,
                      inputType: InputType.date,
                      onChanged: (v) {
                        setState(() {
                          edate = v != null ? v : DateTime.now();
                        });
                      },
                      initialValue: DateTime.now(),
                      format: DateFormat("yyyy-MM-dd"),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                                .translate('end_date') ??
                            "End date",
                      ),
                    ),
                  ),
                  //Bottom Reset and Apply
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _closeEndDrawer,
                          child: Text(AppLocalizations.of(context)!
                                  .translate('reset') ??
                              "Reset"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: logolightGreen,
                          ),
                          onPressed: () {
                            _applyEndDrawer();
                          },
                          child: Text(
                            AppLocalizations.of(context)!.translate('apply') ??
                                "Apply",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
