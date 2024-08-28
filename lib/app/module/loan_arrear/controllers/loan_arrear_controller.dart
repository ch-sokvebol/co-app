import 'dart:convert';
import 'dart:io';

import 'package:chokchey_finance/app/module/loan_arrear/models/Get_arr_follow_up_model.dart';
import 'package:chokchey_finance/app/module/loan_arrear/models/brance_model.dart';
import 'package:chokchey_finance/app/module/loan_arrear/models/filter_model.dart';
import 'package:chokchey_finance/app/module/loan_arrear/models/all_option_model.dart';
import 'package:chokchey_finance/app/module/loan_arrear/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../providers/manageService.dart';
import '../../../../utils/storages/const.dart';
import '../../../utils/colors/app_color.dart';
import '../../../utils/helpers/local_storage.dart';
import '../../home_new/model/arrear_model_new.dart';
import '../../home_new/model/loan_arrear_model_new.dart';
import '../models/par_arr_home_model.dart';

class LoanArrearController extends GetxController {
  // TabController? _tabController;
  String? searchusername;
  final isLoadinguser = false.obs;
  late TabController tabController;
  // logger() {
  //   var loggers = Logger(
  //     printer: PrettyPrinter(),
  //   );
  //   return loggers;
  //}

  // Future<void> onSeachUserName(String searchName) async {
  //   Future.delayed(Duration(seconds: 2), () {
  //     searchAllCO(searchusername: searchusername);
  //     update();
  //   });
  // }

  final txtUserName = ''.obs;
  final txtUserCodeCopy = ''.obs;
  final txtBranceName = ''.obs;
  final txtBranceCopy = ''.obs;
  final id = ''.obs;
  final userModelsAllCo = FilterUserModel().obs;
  var userLists = <FilterUserModel>[].obs;

  // Future<void> onSearchText(String? searchName) async {
  //   if (searchName!.replaceFirst(' ', '', 0).isNotEmpty) {
  //     await searchAllCO(searchusername: searchName);
  //     userLists.clear();
  //   } else {
  //     // userLists.clear();
  //   }
  // }

  Future<void> searchAllCO(String? searchusername) async {
    isLoadinguser(true);
    final typeUser = await storage.read(key: 'user_type');
    final branCode = await storage.read(key: 'branch');
    try {
      var body = json.encode({
        "pageSize": 20,
        "pageNumber": 1,
        "searchusername": "$searchusername",
        "bcode": typeUser == 'BM' ? '$branCode' : null
      });
      await http
          .post(
              // Uri.parse('https://localhost:5001/api/Users/search'),
              Uri.parse(baseURLInternal + 'Users/search'),
              headers: {'Content-Type': 'application/json'},
              body: body)
          .then((res) {
        var resJson = json.decode(res.body);
        userLists.value = [];
        resJson.map((e) {
          userModelsAllCo.value = FilterUserModel.fromJson(e);
          userLists.add(userModelsAllCo.value);
        }).toList();
        refresh();
      });
    } catch (Error) {
      isLoadinguser(false);
    } finally {
      isLoadinguser(false);
    }
  }
  // Future<void> searchAllCO({String? searchusername}) async {
  //   isLoadinguser(true);
  //   final typeUser = await storage.read(key: 'user_type');
  //   final branCode = await storage.read(key: 'branch');
  //   try {
  //     // var headers = {'Content-Type': 'application/json'};
  //     var body = json.encode({
  //       "pageSize": 20,
  //       "pageNumber": 1,
  //       "searchusername": "$searchusername",
  //       "bcode": typeUser == 'BM' ? '$branCode' : null
  //       // typeUser == 'BM' ? "$branchCode" : null
  //     });
  //     await http
  //         .post(Uri.parse(baseURLInternal + 'Users/search'),
  //             // Uri.parse('https://localhost:5001/api/Users/search'),
  //             headers: {'Content-Type': 'application/json'},
  //             body: body)
  //         .then((res) {
  //       var resJson = json.decode(res.body);
  //       userLists.value = [];
  //       resJson.map((e) {
  //         userModelsAllCo.value = FilterUserModel.fromJson(e);
  //         userLists.add(userModelsAllCo.value);
  //       }).toList();
  //       refresh();
  //     });
  //     // await http
  //     //     .post(Uri.parse(baseURLInternal + 'Users/search'),

  //     //         headers: {'Content-Type': 'application/json'},
  //     //         body: body)
  //     //     .then((res) {
  //     //   var resJson = json.decode(res.body);
  //     //   // userLists = resJson;
  //     //   userLists.value = [];
  //     //   resJson.map((e) {
  //     //     userModelsAllCo.value = FilterUserModel.fromJson(e);
  //     //     userLists.add(userModelsAllCo.value);
  //     //   }).toList();

  //     //   refresh();
  //     // });
  //   } catch (Error) {
  //     isLoadinguser(false);
  //   } finally {
  //     isLoadinguser(false);
  //   }
  // }

  // List<FilterUserModel> listUser = [];

  final searchList = <FilterUserModel>[].obs;
  final searchModel = FilterUserModel().obs;
  final isLoadingSearch = false.obs;
  Future<List<FilterUserModel>> onFilterUser(String search) async {
    isLoadingSearch(true);
    // String url = 'https://localhost:5001/api/Users/filter?search=$search';
    String url = baseURLInternal + 'Users/filter?search=$search';
    // var body = json.encode({'search': '$search'});
    try {
      await http.get(Uri.parse(url),
          headers: {'Content-Type': 'application/json'}).then((res) {
        if (res.statusCode == 200) {
          searchList.clear();
          var resJson = json.decode(res.body);
          resJson.map((e) {
            searchModel.value = FilterUserModel.fromJson(e);
            searchList.add(searchModel.value);
          }).toList();
          // listUser = resJson;
        } else {
          // debugPrint('erreeeoe:${res.statusCode}');
        }
      });
    } catch (e) {
      isLoadingSearch(false);
    } finally {
      isLoadingSearch(false);
    }
    return searchList;
  }

  final isLoadingBranceName = false.obs;
  final branceModel = BranceModel().obs;
  final branceList = <BranceModel>[].obs;
  Future<List<BranceModel>> getBrance() async {
    isLoadingBranceName(true);
    var token = await storage.read(key: 'user_token');
    var user_ucode = await storage.read(key: "user_ucode");
    try {
      await http.get(
          Uri.parse(
            // 'https://localhost:5001/api/valuelists/branches/ByUser/$user_ucode'
            '$baseURLInternal' + 'valuelists/branches/ByUser/$user_ucode',
          ),
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token"
          }).then((res) {
        if (res.statusCode == 200) {
          var resJson = json.decode(res.body);
          branceList.clear();
          resJson.map((e) {
            branceModel.value = BranceModel.fromJson(e);
            branceList.add(branceModel.value);
          }).toList();
        } else {
          // debugPrint('error:${res.body}');
        }
      });
    } catch (e) {
      isLoadingBranceName(false);
    } finally {
      isLoadingBranceName(false);
    }
    return branceList;
  }

  var datetime = DateTime.now();
  String formartDate = '';
  final filterModel = FilterModel().obs;
  final filterList = <FilterModel>[].obs;
  bool isLoadingFilter = false;
  List getArrearList = <dynamic>[];
  double currencyUSD = 0.0;
  double currencyKhmer = 0.0;
  int? totalAccounts;
  // int? mytotal;
  Future<void> onFilterArrear(
      {String? baseDate,
      String? mgmtBranchCode,
      String? currencyCode,
      String? loanAccountNo,
      String? referenceEmployeeNo}) async {
    isLoadingFilter = true;
    String getDateTimeNow = DateFormat("yyyyMMdd").format(datetime);
    formartDate = getDateTimeNow;
    var body = json.encode({
      "header": {
        "userID": "SYSTEM",
        "channelTypeCode": "08",
        "previousTransactionID": "",
        "previousTransactionDate": ""
      },
      "body": {
        "baseDate": "$baseDate",
        "mgmtBranchCode": "$mgmtBranchCode",
        "currencyCode": "$currencyCode",
        "loanAccountNo": "$loanAccountNo",
        "referenceEmployeeNo": "$referenceEmployeeNo"
      }
    });
    try {
      await http
          .post(
        Uri.parse(baseUrl + 'LEN0001'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          // 'Charset': 'utf-8'
        },
        body: body,
      )
          .then((res) {
        getArrearList.clear();
        if (res.statusCode == 200) {
          var resJson =
              jsonDecode(Utf8Decoder().convert(res.body.codeUnits))['body']
                  ['arrearList'];
          getArrearList = resJson;
          var total =
              jsonDecode(Utf8Decoder().convert(res.body.codeUnits))['body']
                  ['arrearListCount'];
          totalAccounts = total;
          if (getArrearList.length > 0) {
            // var totalAcount = "# ${getArrearList.length}";
            getArrearList.forEach((dynamic e) {
              if (e['currencyCode'] == "USD") {
                currencyUSD += e['totalAmount1'];
              } else {
                currencyKhmer += e['totalAmount1'];
              }
            });
            // resJson = [totalAcount, ...getArrearList];
            // totalAccounts = totalAcount.toString();
            // _isLoading = false;
            // debugPrint('hiii==:${totalAccounts}');
          }
          txtBranceName.value = '';
          txtUserName.value = '';
          txtBranceCopy.value = '';
          txtUserCodeCopy.value = '';
          /////when filter total amount = 0
          if (totalAccounts == 0) {
            currencyUSD = 0;
            currencyKhmer = 0;
          }

          update();
        } else {
        }
      });
    } catch (e) {
      isLoadingFilter = false;
      getArrearList = [];
      totalAccounts = 0;
      currencyKhmer = 0.0;
      currencyUSD = 0.0;
      update();
    } finally {
      isLoadingFilter = false;
    }
  }

  final ratioParAll = 0.0.obs;
  final ratioPar1 = 0.0.obs;
  final ratioPar14 = 0.0.obs;
  final ratioPar30 = 0.0.obs;
  final ratioPar60 = 0.0.obs;
  final ratioPar90 = 0.0.obs;
  // final totalRaio = 0.0.obs;
  ////// filter loan arrear
  final isLoadingFilterNew = false.obs;
  var overDueday;
  final totalAllParUSD = 0.0.obs;
  final totalAllParKHM = 0.0.obs;
  final total1ParUSD = 0.0.obs;
  final total1ParKHM = 0.0.obs;
  final total14ParUSD = 0.0.obs;
  final total14ParKHM = 0.0.obs;
  final total30ParUSD = 0.0.obs;
  final total30ParKHM = 0.0.obs;
  final total60ParUSD = 0.0.obs;
  final total60ParKHM = 0.0.obs;
  final total90ParUSD = 0.0.obs;
  final total90ParKHM = 0.0.obs;

  var userType;
  // var type;
  final ontapFilter = false.obs;
  final txtTitle = ''.obs;
  final txtTitleSub = ''.obs;
  final arrearModel = ArrearModelNew().obs;
  final totalUSDAll = 0.0.obs;
  final totalKHMAll = 0.0.obs;
  final totalAmountAll = 0.0.obs;
  // Arrears 1
  final totalAmount1 = 0.0.obs;
  final totalUSD1 = 0.0.obs;
  final totalKHM1 = 0.0.obs;
  // Arrears 2
  final totalAmount2 = 0.0.obs;
  final totalUSD2 = 0.0.obs;
  final totalKHM2 = 0.0.obs;
  // Arrears 3
  final totalAmount3 = 0.0.obs;
  final totalUSD3 = 0.0.obs;
  final totalKHM3 = 0.0.obs;
  // Arrears 4
  final totalAmount4 = 0.0.obs;
  final totalUSD4 = 0.0.obs;
  final totalKHM4 = 0.0.obs;
  // Arrears 5
  final totalAmount5 = 0.0.obs;
  final totalUSD5 = 0.0.obs;
  final totalKHM5 = 0.0.obs;
  final outstandingBalance = ''.obs;
  // final arrearList = <ArrearModel>[].obs;

  // Dio _dio = Dio();
  final modelNew = LoanArrearModelNew().obs;

  Future<LoanArrearModelNew> onfilterArrearNew({
    String? branchCode,
    String? employeeCode,
    double? overDueday,
    String? baseDate,
  }) async {
    isLoadingFilterNew.value = true;

    // String url = dotenv.get('urlInternal');
    // final url = Uri.parse('https://localhost:5001/api/LoanArrearCopy/arr');
    final url = Uri.parse(baseURLInternal + 'LoanArrearCopy/arr');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = json.encode({
      "BranchCode": "$branchCode",
      "EmployeeCode": "$employeeCode",
      "OverDueDay": overDueday,
      "BaseDate": "$baseDate"
    });
    try {
      final res = await http.post(url, headers: headers, body: body);
      if (res.statusCode == 200) {
        clearData();
        final resjson = jsonDecode(res.body);
        modelNew.value = LoanArrearModelNew.fromJson(resjson);
        Future.delayed(Duration(seconds: 1), () {
          // parAll();
          // getParNew();
          isLoadingFilterNew.value = false;
        });

        update();
        return modelNew.value;
      } else {
        // isLoadingFilterNew.value = false;
        return modelNew.value;
      }
    } catch (e) {
      isLoadingFilterNew.value = false;
    }

    return modelNew.value;
  }

  parAll() {
    modelNew.value.allArrear!.forEach(
      (e) {
        if (e.currencyCode == "USD") {
          totalUSDAll.value += e.loanBalance!;
        } else {
          totalKHMAll.value += e.loanBalance!;
        }
      },
    );
    var amountKHM = totalKHMAll.value / 4130;
    totalAmountAll.value = amountKHM + totalUSDAll.value;
    // PAR 1
    modelNew.value.arrear1Day!.forEach(
      (e) {
        if (e.currencyCode == "USD") {
          totalUSD1.value += e.loanBalance!;
        } else {
          totalKHM1.value += e.loanBalance!;
        }
      },
    );
    var amountKHM1 = totalKHM1.value / 4130;
    totalAmount1.value = amountKHM1 + totalUSD1.value;

    // PAR 2
    modelNew.value.arrear14Days!.forEach((e) {
      if (e.currencyCode == "USD") {
        totalUSD2.value += e.loanBalance!;
      } else {
        totalKHM2.value += e.loanBalance!;
      }
    });
    var amountKHM2 = totalKHM2.value / 4130;
    totalAmount2.value = amountKHM2 + totalUSD2.value;

    // PAR 3
    modelNew.value.arrear30Days!.forEach((e) {
      if (e.currencyCode == "USD") {
        totalUSD3.value += e.loanBalance!;
      } else {
        totalKHM3.value += e.loanBalance!;
      }
    });
    var amount3 = totalKHM3.value / 4130;
    totalAmount3.value = amount3 + totalUSD3.value;

    //4
    modelNew.value.arrear60Days!.forEach((e) {
      if (e.currencyCode == "USD") {
        totalUSD4.value += e.loanBalance!;
      } else {
        totalKHM4.value += e.loanBalance!;
      }
    });
    var amount4 = totalKHM4.value / 4130;
    totalAmount4.value = amount4 + totalUSD4.value;

    //5
    modelNew.value.arrear90Days!.forEach((e) {
      if (e.currencyCode == "USD") {
        totalUSD5.value += e.loanBalance!;
      } else {
        totalKHM5.value += e.loanBalance!;
      }
    });
    var amount5 = totalKHM5.value / 4130;
    totalAmount5.value = amount5 + totalUSD5.value;

    /// Ratio

    if (modelNew.value.outstandingBalance == '') {
      ratioParAll.value = 0.0;
      ratioPar1.value == 0.0;
      ratioPar14.value == 0.0;
      ratioPar30.value == 0.0;
      ratioPar60.value == 0.0;
      ratioPar90.value == 0.0;
    } else {
      ratioParAll.value = totalAmountAll.value *
          100 /
          double.parse('${modelNew.value.outstandingBalance}');
      ratioPar1.value = totalAmount1.value *
          100 /
          double.parse('${modelNew.value.outstandingBalance}');
      ratioPar14.value = totalAmount2.value *
          100 /
          double.parse('${modelNew.value.outstandingBalance}');
      ratioPar30.value = totalAmount3.value *
          100 /
          double.parse('${modelNew.value.outstandingBalance}');
      ratioPar60.value = totalAmount4.value *
          100 /
          double.parse('${modelNew.value.outstandingBalance}');
      ratioPar90.value = totalAmount5.value *
          100 /
          double.parse('${modelNew.value.outstandingBalance}');
    }
  }

  clearData() {
    ratioParAll.value = 0.0;
    ratioPar1.value = 0.0;
    ratioPar14.value = 0.0;
    ratioPar30.value = 0.0;
    ratioPar60.value = 0.0;
    ratioPar90.value = 0.0;
    //
    totalAmount1.value = 0;
    totalAmount2.value = 0;
    totalAmount3.value = 0;
    totalAmount4.value = 0;
    totalAmount5.value = 0;
    totalAmountAll.value = 0;
    //----->

    totalUSDAll.value = 0;
    totalKHMAll.value = 0;
    totalUSD1.value = 0;
    totalKHM1.value = 0;
    totalUSD2.value = 0;
    totalKHM2.value = 0;
    totalUSD3.value = 0;
    totalKHM3.value = 0;
    totalUSD4.value = 0;
    totalKHM4.value = 0;
    totalUSD5.value = 0;
    totalKHM5.value = 0;
    //
    modelNew.value.allArrear = null;
    modelNew.value.arrear14Days = null;
    modelNew.value.arrear1Day = null;
    modelNew.value.arrear30Days = null;
    modelNew.value.arrear60Days = null;
    modelNew.value.arrear90Days = null;
  }

  onCheckPar() async {
    final currentDate = DateTime.now();
    var date = DateFormat("yyyyMMdd").format(
        DateTime(currentDate.year, currentDate.month, currentDate.day - 1));
    var type = await storage.read(key: 'user_type');
    var branchCode = await storage.read(key: 'branch');
    var empCode = await storage.read(key: 'user_ucode');
    if (type == "CO") {
      onfilterArrearNew(
        baseDate: '$date',
        employeeCode: '$empCode',
        overDueday: 0,
        branchCode: '',
      );
    } else if (type == "BM" || type == "BTL") {
      onfilterArrearNew(
        baseDate: '$date',
        employeeCode: '',
        overDueday: 0,
        branchCode: '$branchCode',
      );
    } else {
      // For MNG

      onfilterArrearNew(
        baseDate: '$date',
        employeeCode: '',
        overDueday: 0,
        branchCode: '',
      );
    }
  }

  final isLoadingOption = false.obs;
  final allOptionModel = AllOptionArrModel().obs;

  Future<AllOptionArrModel> getOption() async {
    isLoadingOption(true);
    // String url = 'https://localhost:5001/api/Option/get_opt';
    String url = baseURLInternal + 'Option/get_opt';
    try {
      await http.get(Uri.parse(url),
          headers: {'Content-Type': 'application/json'}).then((res) {
        if (res.statusCode == 200) {
          var resJson = json.decode(res.body);
          allOptionModel.value = AllOptionArrModel.fromJson(resJson);
          update();
          refresh();
        }
      });
    } catch (e) {
      isLoadingOption(false);
    } finally {
      isLoadingOption(false);
    }
    return allOptionModel.value;
  }

  final parArrHomeModel = ParArrHomeModel().obs;
  final parArrHomeList = <ParArrHomeModel>[].obs;
  final isLoadingParArrHome = false.obs;
  Future<ParArrHomeModel> getParArrHome(
      {String? branchCode,
      String? employeeCode,
      String? baseDate,
      num? overdueDay}) async {
    isLoadingParArrHome.value = true;
    try {
      // final url = 'https://localhost:5001/api/LoanArrearCopy/summery_par';
      final url = baseURLInternal + "LoanArrearCopy/summery_par";
      print(url);
      final header = {'Content-Type': 'application/json'};
      final body = json.encode({
        "BranchCode": "$branchCode",
        "EmployeeCode": "$employeeCode",
        "OverDueDay": overdueDay,
        "BaseDate": "$baseDate"
      });
      print('-----Request par arrears------------$body');
      final res = await http.post(Uri.parse(url), headers: header, body: body);
      print(res.statusCode);
      if (res.statusCode == 200) {
        var resJson = json.decode(res.body);
        debugPrint('body Arrears: ${res.body}');
        parArrHomeModel.value = ParArrHomeModel.fromJson(resJson);
      }
      isLoadingParArrHome.value = false;
    } catch (e) {
    } finally {
      isLoadingParArrHome.value = false;
    }

    return parArrHomeModel.value;
  }

  final isLoadingUpload = false.obs;
  late File? fileImage;
  final imageFile = File('').obs;
  // File imgFile = File('imagePath');
  final imagePathFile = ''.obs;
  // File file = File(image!.path);
  Future onChooseImage({ImageSource? media, File? fileimg}) async {
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: media!);
    File? file;

    if (img != null) {
      // File imgFile = File(img.path);
      // fileImage = imgFile;
      file = File(img.path);
      imageFile.value = file;
      update();
    }

    // debugPrint("${imagePathFile.value}");
  }

  // _getFromGallery() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   // if (pickedFile != null) {
  //   //   File imageFile = File(pickedFile.path);
  //   // }
  //   final img = File(pickedFile!.path);
  // }

  Future<String> uploadImage(File imageFile, String loanId) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseURLInternal + 'ArrearFollowUp/upload_file'));
    // Uri.parse('https://localhost:5001/api/ArrearFollowUp/upload_file'));

    // Add the image file to the request
    var imageStream = http.ByteStream(imageFile.openRead());

    var length = await imageFile.length();

    var multipartFile = http.MultipartFile('imageFile', imageStream, length,
        filename: imageFile.path);
    request.files.add(multipartFile);
    request.fields["name"] = loanId;

    var response = await request.send();

    if (response.statusCode == 200) {
      // Image uploaded successfully, retrieve the uploaded file name
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      return responseString;
    } else {
      // Error occurred while uploading the image
      // throw Exception('Error: ${response.reasonPhrase}');
      return '${response.reasonPhrase}';
    }
  }

  Future<String> onDeleteImage(File imageFile) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://localhost:5001/api/ArrearFollowUp/deleteImage'));

    // Add the image file to the request
    var imageStream = http.ByteStream(imageFile.openRead());

    var length = await imageFile.length();

    var multipartFile = http.MultipartFile('img', imageStream, length,
        filename: imageFile.path);
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      // Image uploaded successfully, retrieve the uploaded file name
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      return responseString;
    } else {
      // Error occurred while uploading the image
      // throw Exception('Error: ${response.reasonPhrase}');
      return '${response.reasonPhrase}';
    }
  }

  ///////////////// arrear follow up new
  final txtClientComNew = ''.obs;
  final isClientComNew = false.obs;
  TextEditingController txtPayFullDate = TextEditingController();
  final isPayFullDate = false.obs;
  final txtPayFullAmt = 0.0.obs;
  final isPayFullAmt = false.obs;
  TextEditingController txtRevolvingDate = TextEditingController();
  final isRevolvingDate = false.obs;
  TextEditingController txtDisburseDate = TextEditingController();
  final isDisburseDate = false.obs;
  TextEditingController txtColllateralDate = TextEditingController();
  final isCollateralDate = false.obs;
  final txtCollateralSellAmt = 0.0.obs;
  final isCollateralSellAmt = false.obs;
  //////
  final txtStatusNew = ''.obs;
  final isStatusNew = false.obs;
  TextEditingController txtStatusPayDate = TextEditingController();
  final isStatusPayDate = false.obs;
  final txtStatusPayAmt = 0.0.obs;
  final isStatusPayAmt = false.obs;
  final isValidateStatus = false.obs;
  //////
  final txtReasonNew = ''.obs;
  final isReasonNew = false.obs;
  final txtJobName = ''.obs;
  final isJobName = false.obs;
  final txtWorkplace = ''.obs;
  final isWorkPlace = false.obs;
  final txtSolvingNew = ''.obs;
  final isSolvingNew = false.obs;
  final txtRemarkNew = ''.obs;
  final isRemarkNew = false.obs;
  final txtTypeNew = ''.obs;
  final isTypeNew = false.obs;

  final isValidClientCom = false.obs;

  TextEditingController fullAmt = TextEditingController();
  onClearArrFollow() async {
    txtReasonNew.value = '';
    txtSolvingNew.value = '';
    txtClientComNew.value = '';
    txtRemarkNew.value = '';
    imageFile.value = File('');
    txtPayFullDate.text = '';
    txtPayFullAmt.value = 0.0;
    txtColllateralDate.text = '';
    txtRevolvingDate.text = '';
    txtDisburseDate.text = '';
    txtCollateralSellAmt.value = 0.0;
    txtStatusNew.value = '';
    txtStatusPayAmt.value = 0.0;
    txtStatusPayDate.text = '';
    txtTypeNew.value = '';
    txtJobName.value = '';
    txtWorkplace.value = '';
  }

  final isLoadingArrUp = false.obs;
  final txtDescription = ''.obs;
  final isDescription = false.obs;
  final isoccu = false.obs;
  final isCompany = false.obs;
  final isImage = false.obs;
  final txtCompanyName = ''.obs;
  final overdueAmount = ''.obs;
  final status = ''.obs;
  final createdDate = ''.obs;
  final createdBy = ''.obs;

  XFile? image;
  Future<void> onArrFollowUp({
    BuildContext? context,
    num? latitude,
    num? longitude,
    String? village,
    String? commune,
    String? district,
    String? province,
    String? customerCode,
    String? customerName,
    String? loanNumber,
    num? loanAmount,
    num? overdueDay,
    String? coName,
    String? coId,
    String? brancCode,
    String? brancName,
    String? repaymentDate,
    num? loanPeriod,
    num? overdueAmt,
    String? loanId,
    String? currencyCode,
    num? loanBalance,
  }) async {
    final currentDate = DateTime.now();
    // var date = DateFormat("yyyyMMdd").format(
    //     DateTime());
    isLoadingArrUp(true);
    String url = baseURLInternal + 'ArrearFollowUp/FollowUp';
    // String url = 'https://localhost:5001/api/ArrearFollowUp/FollowUp';
    try {
      var body = json.encode({
        "reason": "${txtReasonNew.value}",
        "solvingStatus": "${txtSolvingNew.value}",
        "clientCommitment": "${txtClientComNew.value}",
        "clientPayDate": "${txtPayFullDate.text}",
        "clientPayAmt": "${txtPayFullAmt.value}",
        "revolvingDate": "${txtRevolvingDate.text}",
        "disburseDate": "${txtDisburseDate.text}",
        "sellDate": "${txtColllateralDate.text}",
        "sellAmt": "${txtCollateralSellAmt.value}",
        "status": "${txtStatusNew.value}",
        "completPartialAmt": "${txtStatusPayAmt.value}",
        "completPartialDate": "${txtStatusPayDate.text}",
        "remark": "${txtRemarkNew.value}",
        "imageUrl": "${imagePathFile.value}",
        "village": "${village}",
        "commune": "${commune}",
        "district": "${district}",
        "province": "${province}",
        "customercode": "${customerCode}",
        "customername": "${customerName}",
        "loannumber": "${loanNumber}",
        "loanamount": "${loanAmount}",
        "overdueday": "${overdueDay}",
        "overdueamount": "$overdueAmt",
        "coname": "${coName}",
        "coid": "${coId}",
        "latitude": "${latitude}",
        "longitude": "${longitude}",
        "branchcode": "${brancCode}",
        "branchname": "${brancName}",
        "repaymentdate": "${repaymentDate}",
        "loanperiod": "${loanPeriod}",
        "createddate": "$currentDate",
        "createdby": "$coName",
        "jobName": "${txtJobName.value}",
        "workPlace": "${txtWorkplace.value}",
        "Type": "${txtTypeNew.value}",
        "currencyCode": "$currencyCode",
        "loanBalance": "$loanBalance"
      });
      await http
          .post(Uri.parse(url),
              headers: {'Content-Type': 'application/json'}, body: body)
          .then((res) {
        if (res.statusCode == 200) {
          Navigator.pop(context!);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Successfully',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
              dismissDirection: DismissDirection.up,
              backgroundColor: AppColors.logolightGreen,
              duration: Duration(seconds: 3),
              showCloseIcon: true,
              closeIconColor: Colors.white,
            ),
          );
        } else {}
      });
    } catch (e) {
      isLoadingArrUp(false);
    } finally {
      isLoadingArrUp(false);
    }
  }

  final isLoadingGetFollowUp = false.obs;
  final getArrFollowModel = GetArrFollowUpModel().obs;
  final getArrFollowList = <GetArrFollowUpModel>[].obs;

  Future<List<GetArrFollowUpModel>> getArrFollowUp(
      {String? loanNumber, String? empCode, String? branchCode}) async {
    isLoadingGetFollowUp.value = true;
    // final url = 'https://localhost:5001/api/ArrearFollowUp/GetFollowUp';
    final url = baseURLInternal + 'ArrearFollowUp/GetFollowUp';
    final header = {'Content-Type': 'application/json'};
    final body = json.encode({
      "loannumber": "$loanNumber",
      "coid": "$empCode",
      "branchcode": "$branchCode"
    });
    try {
      final res = await http.post(Uri.parse(url), headers: header, body: body);
      getArrFollowList.isEmpty;
      if (res.statusCode == 200) {
        getArrFollowList.clear();
        var resJson = json.decode(res.body);
        debugPrint('test===:${resJson}');
        resJson.map((e) {
          getArrFollowModel.value = GetArrFollowUpModel.fromJson(e);
          getArrFollowList.add(getArrFollowModel.value);
        }).toList();
        isLoadingGetFollowUp.value = false;
      } else {
        debugPrint('errorrrr:${res.statusCode}');
      }
    } catch (e) {
      isLoadingGetFollowUp.value = false;
    } finally {
      isLoadingGetFollowUp.value = false;
    }
    return getArrFollowList;
  }

  final radio1 = 0.0.obs;
  final radio14 = 0.0.obs;
  final radio30 = 0.0.obs;
  final radio60 = 0.0.obs;
  final radio90 = 0.0.obs;
  final acc1 = 0.obs;
  final acc14 = 0.obs;
  final acc30 = 0.obs;
  final acc60 = 0.obs;
  final acc90 = 0.obs;
  final amt1 = 0.0.obs;
  final amt14 = 0.0.obs;
  final amt30 = 0.0.obs;
  final amt60 = 0.0.obs;
  final amt90 = 0.0.obs;
  final totalAcc = 0.obs;
  final totalAmt = 0.0.obs;
  onstoreLocal() async {
    await LocalStorage.storeData(key: 'radio1', value: ratioPar1.value);
    await LocalStorage.storeData(key: 'radio14', value: ratioPar14.value);
    await LocalStorage.storeData(key: 'radio30', value: ratioPar30.value);
    await LocalStorage.storeData(key: 'radio60', value: ratioPar60.value);
    await LocalStorage.storeData(key: 'radio90', value: ratioPar90.value);
    await LocalStorage.storeData(
        key: 'acc1', value: modelNew.value.arrear1Day!.length);
    await LocalStorage.storeData(
        key: 'acc14', value: modelNew.value.arrear14Days!.length);
    await LocalStorage.storeData(
        key: 'acc30', value: modelNew.value.arrear30Days!.length);
    await LocalStorage.storeData(
        key: 'acc60', value: modelNew.value.arrear60Days!.length);
    await LocalStorage.storeData(
        key: 'acc90', value: modelNew.value.arrear90Days!.length);
    await LocalStorage.storeData(key: 'amt1', value: totalAmount1.value);
    await LocalStorage.storeData(key: 'amt14', value: totalAmount2.value);
    await LocalStorage.storeData(key: 'amt30', value: totalAmount3.value);
    await LocalStorage.storeData(key: 'amt60', value: totalAmount4.value);
    await LocalStorage.storeData(key: 'amt90', value: totalAmount5.value);
    await LocalStorage.storeData(
        key: 'totalAcc', value: modelNew.value.allArrear!.length);
    await LocalStorage.storeData(key: 'totalAmt', value: totalAmountAll.value);
  }

  onGetHomePar() async {
    // var res = await sqliteHelper!.queryData(sql: 'Select * from HomeParArrear');
    // debugPrint('$res');
    //  r await LocalStorage.getDoubleValue(key: 'radio1');
    radio1.value = await LocalStorage.getDoubleValue(key: 'radio1');
    radio14.value = await LocalStorage.getDoubleValue(key: 'radio14');
    radio30.value = await LocalStorage.getDoubleValue(key: 'radio30');
    radio60.value = await LocalStorage.getDoubleValue(key: 'radio60');
    radio90.value = await LocalStorage.getDoubleValue(key: 'radio90');
    acc1.value = await LocalStorage.getIntValue(key: 'acc1');
    acc14.value = await LocalStorage.getIntValue(key: 'acc14');
    acc30.value = await LocalStorage.getIntValue(key: 'acc30');
    acc60.value = await LocalStorage.getIntValue(key: 'acc60');
    acc90.value = await LocalStorage.getIntValue(key: 'acc90');
    amt1.value = await LocalStorage.getDoubleValue(key: 'amt1');
    amt1.value = await LocalStorage.getDoubleValue(key: 'amt14');
    amt30.value = await LocalStorage.getDoubleValue(key: 'amt30');
    amt60.value = await LocalStorage.getDoubleValue(key: 'amt60');
    amt90.value = await LocalStorage.getDoubleValue(key: 'amt90');
    totalAcc.value = await LocalStorage.getIntValue(key: 'totalAcc');
    totalAmt.value = await LocalStorage.getDoubleValue(key: 'totalAmt');
  }
}
