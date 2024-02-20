// ignore_for_file: unused_local_variable, unnecessary_null_comparison, must_call_super, deprecated_member_use

import 'dart:convert';

import 'package:chokchey_finance/app/utils/helpers/check_deveice.dart';
import 'package:chokchey_finance/localizations/appLocalizations.dart';
import 'package:chokchey_finance/providers/lmapProvider/index.dart';
import 'package:chokchey_finance/providers/manageService.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:chokchey_finance/utils/storages/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';
import '../../app/module/lmap_data/custom/custom_status.dart';
import 'dropDownLmap.dart';

class LMapScreen extends StatefulWidget {
  const LMapScreen({Key? key}) : super(key: key);

  @override
  State<LMapScreen> createState() => _LMapScreenState();
}

class _LMapScreenState extends State<LMapScreen> {
  var currentDate;
  @override
  void didChangeDependencies() {
    // fetchLamp("0", "", "", "", "");
    DateTime now = new DateTime.now();
    var date = DateFormat('dd MMMM, yyyy')
        .format(DateTime(now.year, now.month, now.day));
    currentDate = date;
  }

  Future<void> onActivityLog({
    String? userId,
    String? description,
  }) async {
    String url = dotenv.get('urlInternal');
    String device = await DeviceInfo.getInfoDevice().then((res) {
      // device = res;

      return res;
    });

    try {
      var body = json.encode({
        "user_id": userId,
        "description": description,
        "device_name": device
      });

      await http
          .post(Uri.parse('${url}activitylog'),
              headers: {'content-type': 'application/json'}, body: body)
          .then((res) {
        if (res.statusCode == 200) {
          // debugPrint('okkkk=========>ssss:${description}');
        } else {
          debugPrint('error=========>:${res.body}');
          debugPrint('error status=========>:${res.statusCode}');
        }
      });
    } finally {}
  }

  var pageSizes = "10";
  bool isLoading = false;
  Future fetchLamp(
    pageSize,
    province,
    district,
    commune,
    village,
  ) async {
    setState(() {
      isLoading = true;
    });
    final userId = await storage.read(key: 'user_ucode');
    onActivityLog(
      userId: '$userId',
      description: 'LMAP $province $district $commune $village',
    );
    context
        .read<LmapProvider>()
        .getLmap(
          pageSize: "$pageSize",
          province: "$province",
          district: "$district",
          commune: "$commune",
          village: "$village",
        )
        .then((value) {
      debugPrint('from lmap+++++++:${value}');
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
    });
  }

  getDistrict(stateProvince) async {
    String url = dotenv.get('urlInternal');
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'GET',
          // Uri.parse(baseURLInternal + 'addresses/district/' + stateProvince));
          Uri.parse('${url}addresses/district/$stateProvince'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final parsed = jsonDecode(await response.stream.bytesToString());
        setState(() {
          listDistricts = parsed;
        });
      } else {
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('error $error');
    }
  }

  getCommune(listDistrict, String? province) async {
    String url = dotenv.get('urlInternal');
    try {
      var request = await http.Request(
        'GET',
        // Uri.parse(baseURLInternal + 'addresses/commune/$listDistrict'));
        Uri.parse('${url}addresses/commune/$listDistrict/$province'),
        // Uri.parse(
        //     'https://localhost:5001/api/Addresses/commune/$listDistrict/$province'),
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final parsed = jsonDecode(await response.stream.bytesToString());
        setState(() {
          listComunes = parsed;
        });
      } else {
        setState(() {
          listComunes = [];
        });
      }
    } catch (error) {
      setState(() {
        listComunes = [];
      });
    }
  }

  getVillage(selectedValueCommune, String? province) async {
    //selectProvincByVillage add parameter to getVillage
    String url = dotenv.get('urlInternal');
    try {
      final Response response = await api().get(
        // Uri.parse(
        //     baseURLInternal + 'addresses/village/' + selectedValueCommune),
        Uri.parse('${url}addresses/village/$selectedValueCommune/$province'),
        // Uri.parse(
        //     'https://localhost:5001/api/Addresses/village/$selectedValueCommune/$province'),

        // Uri.parse('https://localhost:5001/api/addresses/village/' +
        //     selectedValueCommune +
        //     "/$selectProvincByVillage"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      // debugPrint('pro+++:${response.body['zone_code']}');
      debugPrint('pro+++111:$selectedValueCommune');
      final parsed = jsonDecode(response.body);
      List<VillageModel> list = VillageModel.fromJsonList(parsed) ?? [];
      setState(() {
        listVillages = list;
      });
    } catch (error) {
      debugPrint("error--- $error");
    }
  }

  var idProvince;
  var idDistrict;
  var idCommune;
  var idVillage;
  UnfocusDisposition disposition = UnfocusDisposition.scope;
  var stateProvince;
  var selectedValueProvince;
  bool validateVillage = false;
  var selectedValueDistrict;
  var selectedValueCommune;
  String? selectedValueVillage;

  var districtreadOnlys = false;
  var communereadOnlys = false;
  var villagereadOnlys = false;
  var listDistricts = [];
  var listComunes = [];
  List<VillageModel> listVillages = [];
  VillageModel? villageModel;
  double heightWidthContant = 25;

  var _onSelectVillageDisplay;
  @override
  Widget build(BuildContext context) {
    final testData = [
      "ពុំទាន់មានទិន្នន័យ",
      "បានកំណត់តំបន់សំរាប់ធ្វើការវាស់វែង",
      "បានវាស់វែង និង ចែកបង្កាន់ដៃវាស់វែង​",
      "បានចែកវិញ្ញាបនបត្រសម្គាល់អចលនវត្ថុ"
    ];
    return Consumer<LmapProvider>(
      builder: (context, myModel, child) {
        return WillPopScope(
          onWillPop: null,
          child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: Text(
                AppLocalizations.of(context)!.translate('lmap_data') ??
                    'LMAP Data',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: logolightGreen,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  myModel.clearLmap();
                },
              ),
            ),
            body: isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: logolightGreen,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 25, right: 10, left: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            //Province
                            Expanded(
                              child: DropDownLmapRegister(
                                elevation: 0,
                                icons: null,
                                validate: validateVillage
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.red, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                onInSidePress: () async {
                                  FocusScope.of(context)
                                      .unfocus(disposition: disposition);
                                  final storage = new FlutterSecureStorage();
                                  var token =
                                      await storage.read(key: 'user_token');
                                  var list;
                                  try {
                                    final Response response = await api().get(
                                      Uri.parse(baseURLInternal +
                                          'addresses/province'),
                                      headers: {
                                        "Content-Type": "application/json",
                                      },
                                    );
                                    list = jsonDecode(response.body);
                                    setState(() {
                                      stateProvince = list ?? '';
                                    });
                                  } catch (error) {}
                                  // Province
                                  SelectDialog.showModal<String>(
                                    context,
                                    backgroundColor: Colors.white,
                                    label: AppLocalizations.of(context)!
                                            .translate('search') ??
                                        'Search',
                                    items: List.generate(list.length,
                                        (index) => "${list[index]}"),
                                    onChange: (value) async {
                                      if (mounted) {
                                        FocusScope.of(context)
                                            .unfocus(disposition: disposition);
                                        setState(() {
                                          // Province1
                                          selectedValueProvince = value;
                                          selectedValueDistrict = "ស្រុក/ខណ្ឌ";
                                          selectedValueCommune = "ឃុំ/សងា្កត់";
                                          _onSelectVillageDisplay = "ភូមិ";
                                          selectedValueVillage = null;
                                          districtreadOnlys = true;
                                        });
                                        myModel.clearLmap();
                                      }
                                    },
                                  );
                                },
                                selectedValue: selectedValueProvince,
                                texts: selectedValueProvince != null
                                    ? selectedValueProvince
                                    : "ខេត្ត/ក្រុង",
                                title: selectedValueProvince != null
                                    ? selectedValueProvince
                                    : "ខេត្ត/ក្រុង",
                                clear: true,
                                readOnlys: true,
                                iconsClose: Icon(Icons.close),
                                onPressed: () {
                                  if (mounted) {
                                    FocusScope.of(context)
                                        .unfocus(disposition: disposition);
                                    setState(() {
                                      selectedValueProvince = "ខេត្ត/ក្រុង";
                                      selectedValueDistrict = "ស្រុក/ខណ្ឌ";
                                      selectedValueCommune = "ឃុំ/សងា្កត់";
                                      _onSelectVillageDisplay = "ភូមិ";
                                      selectedValueVillage = null;
                                      districtreadOnlys = false;
                                      communereadOnlys = false;
                                      villagereadOnlys = false;
                                      myModel.clearLmap();
                                    });
                                  }
                                },
                                styleTexts: selectedValueProvince != ''
                                    ? TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: fontSizeXs,
                                        color: Colors.black,
                                        fontWeight: fontWeight500)
                                    : TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: fontSizeXs,
                                        color: Colors.grey,
                                        fontWeight: fontWeight500),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            // District
                            Expanded(
                              child: DropDownLmapRegister(
                                isPhoneXParam: isIphoneX(context)
                                    ? widthView(context, 0.37)
                                    : null,
                                icons: Icons.location_on,
                                selectedValue: selectedValueDistrict,
                                validate: validateVillage
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.red, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                texts: selectedValueDistrict != null
                                    ? selectedValueDistrict
                                    : "ស្រុក/ខណ្ឌ",
                                title: selectedValueDistrict != null
                                    ? selectedValueDistrict
                                    : "ស្រុក/ខណ្ឌ",
                                clear: true,
                                iconsClose: Icon(Icons.close),
                                onInSidePress: () async {
                                  if (mounted) {
                                    FocusScope.of(context)
                                        .unfocus(disposition: disposition);
                                    if (districtreadOnlys == true) {
                                      await getDistrict(selectedValueProvince);
                                      await SelectDialog.showModal<String>(
                                        context,
                                        backgroundColor: Colors.white,
                                        label: AppLocalizations.of(context)!
                                                .translate('search') ??
                                            'Search',
                                        items: List.generate(
                                            listDistricts.length,
                                            (index) =>
                                                "${listDistricts[index]}"),
                                        onChange: (value) {
                                          setState(
                                            () {
                                              selectedValueDistrict = value;
                                              selectedValueCommune =
                                                  "ឃុំ/សងា្កត់";
                                              _onSelectVillageDisplay = "ភូមិ";
                                              communereadOnlys = true;
                                            },
                                          );
                                          myModel.clearLmap();
                                        },
                                      );
                                    }
                                  }
                                },
                                onPressed: () {
                                  if (mounted) {
                                    setState(
                                      () {
                                        selectedValueDistrict = "ស្រុក/ខណ្ឌ";
                                        selectedValueCommune = "ឃុំ/សងា្កត់";
                                        _onSelectVillageDisplay = "ភូមិ";
                                        selectedValueVillage = null;
                                        villagereadOnlys = false;
                                        communereadOnlys = false;
                                        myModel.clearLmap();
                                      },
                                    );
                                  }
                                },
                                readOnlys: districtreadOnlys,
                                styleTexts: selectedValueDistrict != ''
                                    ? TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: fontSizeXs,
                                        color: Colors.black,
                                        fontWeight: fontWeight500)
                                    : TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: fontSizeXs,
                                        color: Colors.grey,
                                        fontWeight: fontWeight500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        //.........
                        Row(
                          children: [
                            // Communce
                            Expanded(
                              child: DropDownLmapRegister(
                                icons: Icons.location_on,
                                selectedValue: selectedValueCommune,
                                validate: validateVillage
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.red, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                iconsClose: Icon(Icons.close),
                                onInSidePress: () async {
                                  if (mounted) {
                                    FocusScope.of(context)
                                        .unfocus(disposition: disposition);
                                    if (communereadOnlys == true) {
                                      await getCommune(selectedValueDistrict,
                                          selectedValueProvince);
                                      await SelectDialog.showModal<String>(
                                        context,
                                        backgroundColor: Colors.white,
                                        label: AppLocalizations.of(context)!
                                                .translate('search') ??
                                            'Search',
                                        items: List.generate(listComunes.length,
                                            (index) => "${listComunes[index]}"),
                                        onChange: (
                                          value,
                                        ) async {
                                          setState(() {
                                            selectedValueCommune = value;
                                            _onSelectVillageDisplay = "ភូមិ";
                                            villagereadOnlys = true;
                                          });
                                          myModel.clearLmap();
                                          //...........................
                                          await getVillage(selectedValueCommune,
                                              selectedValueProvince);
                                        },
                                      );
                                    }
                                  }
                                },
                                onPressed: () {
                                  if (mounted) {
                                    setState(() {
                                      selectedValueCommune = "ឃុំ/សងា្កត់";
                                      _onSelectVillageDisplay = "ភូមិ";
                                      selectedValueVillage = null;
                                      villagereadOnlys = false;
                                      myModel.clearLmap();
                                    });
                                  }
                                },
                                texts: selectedValueCommune != null
                                    ? selectedValueCommune
                                    : "ឃុំ/សងា្កត់",
                                title: selectedValueCommune != null
                                    ? selectedValueCommune
                                    : "ឃុំ/សងា្កត់",
                                clear: true,
                                styleTexts: selectedValueCommune != ''
                                    ? TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: fontSizeXs,
                                        color: Colors.black,
                                        fontWeight: fontWeight500)
                                    : TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: fontSizeXs,
                                        color: Colors.grey,
                                        fontWeight: fontWeight500),
                                readOnlys: communereadOnlys,
                              ),
                            ),
                            // Village
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  side: BorderSide(
                                      color: Colors.grey.withOpacity(0.4)),
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.only(left: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  if (selectedValueCommune != null &&
                                      selectedValueCommune != "ឃុំ/សងា្កត់")
                                    SelectDialog.showModal<String>(
                                        // SelectDialog.showModal<VillageModel>(
                                        context,
                                        backgroundColor: Colors.white,
                                        label: AppLocalizations.of(context)!
                                                .translate('search') ??
                                            'Search',
                                        items: List.generate(
                                          listVillages.length,
                                          (index) => listVillages[index].name,
                                        ), itemBuilder: (BuildContext context,
                                            // VillageModel model,
                                            String villageName,
                                            bool isSelected) {
                                      return Container(
                                        decoration: !isSelected
                                            ? null
                                            : BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                        child: ListTile(
                                          selected: isSelected,
                                          title: Text(
                                            // model.name,
                                            villageName,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }, onChange: ((selectedItem) async {
                                      setState(
                                        () {
                                          // selectedValueVillage =
                                          //     selectedItem.idCode;
                                          // debugPrint(
                                          //     "----123 ${selectedItem.idCode}");
                                          // _onSelectVillageDisplay =
                                          //     selectedItem.name;
                                          // debugPrint(
                                          //     "----idcode ${selectedItem.idCode}");
                                          // debugPrint(
                                          //     "----name ${selectedItem.name}");

                                          /// get village id code by village name
                                          final idCode = listVillages
                                              .firstWhere((element) =>
                                                  element.name.toLowerCase() ==
                                                  selectedItem.toLowerCase())
                                              .idCode;
                                          selectedValueVillage = idCode;
                                          _onSelectVillageDisplay =
                                              selectedItem;
                                          debugPrint(
                                              'selecrt village====:$idCode');
                                          debugPrint(
                                              'selecrt village====22222:$selectedItem');
                                        },
                                      );

                                      myModel.clearLmap();
                                    }), autofocus: false);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //  Center(),
                                    Container(
                                      padding: EdgeInsets.only(left: 20),
                                      // width: isIphoneX(context) ? 120 : 110,
                                      child: Text(
                                        "${_onSelectVillageDisplay != null ? _onSelectVillageDisplay : "ភូមិ"}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: fontWeight500),
                                      ),
                                    ),
                                    IconButton(
                                      color: Colors.blue,
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        setState(() {
                                          selectedValueVillage = null;
                                          _onSelectVillageDisplay = null;
                                          myModel.clearLmap();
                                        });
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: logolightGreen,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: logolightGreen)),
                            textStyle: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            if (_onSelectVillageDisplay == "ភូមិ") {
                              setState(() {
                                selectedValueVillage = "";
                              });
                            }
                            fetchLamp(
                              "$pageSizes",
                              "$selectedValueProvince",
                              "$selectedValueDistrict",
                              "$selectedValueCommune",
                              "$selectedValueVillage",
                            );
                          },
                          child: Container(
                            height: 38,
                            child: Center(
                              child: Text("ស្វែងរក",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widthView(context, 0.05),
                        ),
                        if (myModel.parsed.length == 0)
                          Container(
                            width: widthView(context, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "ដំណាក់កាលស្ថានភាព",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: widthView(context, 0.65),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomStatusLMap(
                                        title: 'ពុំទាន់មានទិន្នន័យ',
                                        color: Colors.white,
                                      ),
                                      CustomStatusLMap(
                                        title:
                                            'បានកំណត់តំបន់សំរាប់ធ្វើការវាស់វែង',
                                        color: Colors.green,
                                      ),
                                      CustomStatusLMap(
                                        color: Colors.yellow,
                                        title:
                                            'បានវាស់វែង និង ចែកបង្កាន់ដៃវាស់វែង',
                                      ),
                                      CustomStatusLMap(
                                        color: Colors.red,
                                        title:
                                            "បានចែកវិញ្ញាបនបត្រសម្គាល់អចលនវត្ថុ",
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 30,
                        ),
                        if (myModel.parsed.length == 0) Center(),
                        Expanded(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: myModel.parsed.length,
                            itemBuilder: (context, index) {
                              Color myColor = Colors.red;
                              if (myModel.parsed[index]['status'] ==
                                  'ពុំទាន់មានទិន្នន័យ') {
                                myColor = Colors.white;
                              }
                              if (myModel.parsed[index]['status'] ==
                                  'បានកំណត់តំបន់សំរាប់ធ្វើការវាស់វែង') {
                                myColor = Colors.green;
                              }
                              if (myModel.parsed[index]['status'] ==
                                  'បានវាស់វែង និង ចែកបង្កាន់ដៃវាស់វែង') {
                                myColor = Colors.yellow;
                              }
                              if (myModel.parsed[index]['status'] ==
                                  'បានចែកវិញ្ញាបនបត្រសម្គាល់អចលនវត្ថុ') {
                                myColor = Colors.red;
                              }
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 0,
                                      spreadRadius: 1,
                                      color: Colors.grey.withOpacity(0.2),
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                ),
                                // margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 46,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        color: logolightGreen,
                                      ),
                                      margin: EdgeInsets.only(
                                        bottom: 6,
                                      ),
                                      padding: EdgeInsets.only(
                                          top: 8, left: 10, right: 16),
                                      child: Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "ស្ថានភាព",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: fontWeight700),
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "កាលបរិច្ឆេទចែកប្លង់",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: fontWeight700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      padding:
                                          EdgeInsets.only(left: 4, right: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomStatusLMap(
                                            color: myColor,
                                            title:
                                                "  ${myModel.parsed[index]['status']}",
                                          ),
                                          Container(
                                            height: 50,
                                            // width: widthView(context, 0.2),
                                            child: Center(
                                              child: Text(
                                                myModel.parsed[index]
                                                            ['dates'] !=
                                                        ""
                                                    ? myModel.parsed[index]
                                                        ['dates']
                                                    : "",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    )
                                    // Row(
                                    //   children: [
                                    //     Container(
                                    //       child: Row(
                                    //         children: [
                                    //           // Status LMap
                                    //           Card(
                                    //             color: myColor,
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(
                                    //                         30)),
                                    //             child: Container(
                                    //               height: heightWidthContant,
                                    //               width: heightWidthContant,
                                    //               child: Center(
                                    //                 child: Text(
                                    //                   " ",
                                    //                   style: TextStyle(
                                    //                     fontSize: fontSizeLg,
                                    //                     color: Colors.white,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //           Center(
                                    //             child: Text(
                                    //               "    ${myModel.parsed[index]['status']}",
                                    //             ),
                                    //           ),
                                    //           // Status LMap
                                    //         ],
                                    //       ),
                                    //     ),
                                    //     Container(
                                    //       height: 50,
                                    //       width: widthView(context, 0.2),
                                    //       child: Center(
                                    //         child: Text(
                                    //           myModel.parsed[index]['dates'] !=
                                    //                   ""
                                    //               ? myModel.parsed[index]
                                    //                   ['dates']
                                    //               : "",
                                    //           style: TextStyle(
                                    //               color: Colors.black),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              bottom: isIphoneX(context) ? 30 : 0),
                          child: Text(
                            "កាលបរិច្ឆេទទិន្នន័យ៖ $currentDate​",
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class VillageModel {
  final String idCode;
  final String name;

  VillageModel({
    required this.idCode,
    required this.name,
  });

  factory VillageModel.fromJson(Map<String, dynamic> json) {
    return VillageModel(
      idCode: '${json["village"]}-${json["zone_code"]}',
      name: json["village"],
    );
  }

  static List<VillageModel>? fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => VillageModel.fromJson(item)).toList();
  }
}
