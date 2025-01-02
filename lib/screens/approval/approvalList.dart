import 'dart:convert';
import 'dart:io';

import 'package:chokchey_finance/localizations/appLocalizations.dart';
import 'package:chokchey_finance/providers/manageService.dart';
import 'package:chokchey_finance/screens/detail/index.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:chokchey_finance/utils/storages/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../app/module/home_new/screen/new_homescreen.dart';

// ignore: must_be_immutable
class ApprovalLists extends StatefulWidget {
  static const routeName = '/ApprovalLists';
  bool? isRefresh = false;

  ApprovalLists({this.isRefresh});

  @override
  _ApprovalListsState createState() => new _ApprovalListsState();
}

class _ApprovalListsState extends State<ApprovalLists>
    with SingleTickerProviderStateMixin {
  // _ApprovalListsState(this.isRefresh);

  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  TextEditingController? _searchQuery;
  bool isRefresh = false;
  bool _isSearching = false;
  String searchQuery = "Search query";

  dynamic approvalList = [];

  final images = const AssetImage('assets/images/request.png');

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (isRefresh == true) {
      fetchLoan();
      onLoading();
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => NewHomeScreen()),
            );
          },
        ),
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
        backgroundColor: logolightGreen,
      ),
      body: _isLoading && approvalList == null ||
              approvalList!.length == 0 ||
              approvalList!.length <= 0
          ? Center(
              child: Text(
                AppLocalizations.of(context)!.translate('no_data') ?? 'No Data',
                style: mainTitleBlack,
              ),
            )
          : ListView.builder(
              itemCount: approvalList.length,
              padding: const EdgeInsets.only(top: 20.0),
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  margin: EdgeInsets.only(bottom: 5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: logolightGreen, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        onClickCard(approvalList![index], context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Image(
                            image: images,
                            width: 80,
                            height: 70,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  child: Text(
                                approvalList![index]
                                    ['standardCodeDomainName2']!,
                                style: mainTitleBlack,
                              )),
                              Padding(padding: EdgeInsets.only(bottom: 2)),
                              Text(
                                'Application No: ${approvalList![index]['loanApprovalApplicationNo']}',
                                style: TextStyle(fontSize: 12),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 2)),
                              Text(
                                '${approvalList![index]['authorizationRequestEmpNo']}-${approvalList![index]['authorizationRequestEmpName']}[${approvalList![index]['branchName']}]',
                                style: TextStyle(fontSize: 12),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 2)),
                              Text(
                                '${approvalList![index]['authorizationRequestDate']} ${approvalList![index]['authorizationRequestTime']}',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 40),
                              child: Icon(Icons.keyboard_arrow_right)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future fetchLoan() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final storage = new FlutterSecureStorage();
      String? user_id = await storage.read(key: 'user_id');
      print(user_id);
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(baseUrl + 'LRA0002'));
      request.body =
          "{\n    \"header\": {\n        \"userID\" :\"SYSTEM\",\n\t\t\"channelTypeCode\" :\"08\",\n\t\t\"previousTransactionID\" :\"\",\n\t\t\"previousTransactionDate\" :\"\"\n    },\n    \"body\": {\n    \"authorizerEmployeeNo\": \"$user_id\"\n    }\n}\n";
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(request.body);
      if (response.statusCode == 200) {
        var list = jsonDecode(await response.stream.bytesToString());
        setState(() {
          approvalList = list['body']['approvalList'];
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      logger().e("error: ${error}");
    }
  }

  @override
  void initState() {
    fetchLoan();
    _searchQuery = new TextEditingController();
    super.initState();
  }

  onClickCard(value, context) {
    final loanApprovalApplicationNo = value['loanApprovalApplicationNo'];
    Navigator.of(context).push(
      new MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return new TabBarMenu(loanApprovalApplicationNo);
          },
          fullscreenDialog: true),
    );
  }

  void onLoading() async {
    await new Future.delayed(
      new Duration(seconds: 3),
      () {
        setState(
          () {
            isRefresh = false;
          },
        );
      },
    );
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery!.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: const TextStyle(
            color: Colors.white30,
            fontFamily: 'Segoe UI',
            fontSize: fontSizeSm,
            fontWeight: fontWeight700),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    return new InkWell(
      onTap: () => scaffoldKey.currentState!.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.translate('approval_lists') ??
                  'Approval Lists',
              style: mainTitleStyle,
            ),
          ],
        ),
      ),
    );
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery!.clear();
      updateSearchQuery("Search query");
    });
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(
      () {
        _isSearching = false;
      },
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:chokchey_finance/utils/storages/colors.dart';
// import '../../app/module/home_new/screen/new_homescreen.dart';
// import '../detail/index.dart';
//
// // ignore: must_be_immutable
// class ApprovalLists extends StatefulWidget {
//   static const routeName = '/ApprovalLists';
//   bool? isRefresh = false;
//
//   ApprovalLists({this.isRefresh});
//
//   @override
//   _ApprovalListsState createState() => new _ApprovalListsState();
// }
//
// class _ApprovalListsState extends State<ApprovalLists>
//     with SingleTickerProviderStateMixin {
//   TextEditingController? _searchQuery;
//   bool _isSearching = false;
//   String searchQuery = "Search query";
//
//   // Static data for demonstration
//   List<Map<String, dynamic>> approvalList = [
//     {
//       'standardCodeDomainName2': 'Loan Request A',
//       'loanApprovalApplicationNo': 'LAA-001',
//       'authorizationRequestEmpNo': 'EMP123',
//       'authorizationRequestEmpName': 'John Doe',
//       'branchName': 'Branch X',
//       'authorizationRequestDate': '2022-01-01',
//       'authorizationRequestTime': '10:00 AM',
//     },
//     {
//       'standardCodeDomainName2': 'Loan Request B',
//       'loanApprovalApplicationNo': 'LAA-002',
//       'authorizationRequestEmpNo': 'EMP456',
//       'authorizationRequestEmpName': 'Jane Smith',
//       'branchName': 'Branch Y',
//       'authorizationRequestDate': '2022-01-02',
//       'authorizationRequestTime': '11:00 AM',
//     },
//   ];
//
//   bool _isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         leading: BackButton(
//           onPressed: () {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(builder: (context) => NewHomeScreen()),
//             );
//           },
//         ),
//         title: _isSearching ? _buildSearchField() : _buildTitle(context),
//         actions: _buildActions(),
//         backgroundColor: logolightGreen,
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: approvalList.length,
//         padding: const EdgeInsets.only(top: 20.0),
//         itemBuilder: (context, index) {
//           return Container(
//             height: 100,
//             margin: EdgeInsets.only(bottom: 5.0),
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 side: BorderSide(color: logolightGreen, width: 1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child:InkWell(
//                 splashColor: Colors.blue.withAlpha(30),
//                 onTap: () {
//                   onClickCard(approvalList[index], context);
//                 },
//                 child: Row(
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Icon(Icons.description, size: 50),
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text(
//                             approvalList[index]['standardCodeDomainName2'],
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             'Application No: ${approvalList[index]['loanApprovalApplicationNo']}',
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           Text(
//                             '${approvalList[index]['authorizationRequestEmpNo']}-${approvalList[index]['authorizationRequestEmpName']}[${approvalList[index]['branchName']}]',
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           Text(
//                             '${approvalList[index]['authorizationRequestDate']} ${approvalList[index]['authorizationRequestTime']}',
//                             style: TextStyle(fontSize: 14),
//                           )
//                         ],
//                       ),
//                     ),
//                     Icon(Icons.keyboard_arrow_right),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // void onClickCard(Map<String, dynamic> value, BuildContext context) {
//   //   // Handle card click event
//   //   print("Clicked on: ${value['loanApprovalApplicationNo']}");
//   // }
//
//   List<Widget> _buildActions() {
//     if (_isSearching) {
//       return <Widget>[
//         IconButton(
//           icon: const Icon(Icons.clear),
//           onPressed: () {
//             _clearSearchQuery();
//           },
//         ),
//       ];
//     }
//     return <Widget>[
//       IconButton(
//         icon: const Icon(Icons.search),
//         onPressed: _startSearch,
//       ),
//     ];
//   }
//
//   Widget _buildSearchField() {
//     return TextField(
//       controller: _searchQuery,
//       autofocus: true,
//       decoration: const InputDecoration(
//         hintText: 'Search...',
//         border: InputBorder.none,
//         hintStyle: TextStyle(color: Colors.white30),
//       ),
//       style: const TextStyle(color: Colors.white, fontSize: 16.0),
//       onChanged: updateSearchQuery,
//     );
//   }
//
//   Widget _buildTitle(BuildContext context) {
//     return InkWell(
//       onTap: () {}, // Potentially open a drawer or perform another action
//       child: Text(
//         'Approval Lists',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   void updateSearchQuery(String newQuery) {
//     setState(() {
//       searchQuery = newQuery;
//     });
//   }
//
//   void _clearSearchQuery() {
//     _searchQuery?.clear();
//     updateSearchQuery("Search query");
//   }
//
//   void _startSearch() {
//     setState(() {
//       _isSearching = true;
//     });
//   }
//
//   void onClickCard(Map<String, dynamic> loanDetails, BuildContext context) {
//     final loanApprovalApplicationNo = loanDetails['loanApprovalApplicationNo'];
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => TabBarMenu(loanApprovalApplicationNo),
//       ),
//     );
//   }
//
//
//   void _stopSearching() {
//     _clearSearchQuery();
//     setState(() {
//       _isSearching = false;
//     });
//   }
// }
//
