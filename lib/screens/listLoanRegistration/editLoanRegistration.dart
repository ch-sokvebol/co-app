// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chokchey_finance/components/dropdownCustomersRegister.dart';
import 'package:chokchey_finance/components/groupFormBuilder.dart';
import 'package:chokchey_finance/components/header.dart';
import 'package:chokchey_finance/localizations/appLocalizations.dart';
import 'package:chokchey_finance/providers/manageService.dart';
import 'package:chokchey_finance/screens/loanRegistration/addReferentDocument.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:chokchey_finance/utils/storages/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:select_dialog/select_dialog.dart';

import 'detailLoadRegistration.dart';

class EditLoanRegister extends StatefulWidget {
  final dynamic list;
  EditLoanRegister({this.list});
  @override
  _EditLoanRegister createState() => _EditLoanRegister();
}

class _EditLoanRegister extends State<EditLoanRegister> {
  //IMAGE PICKER
  // List<Asset> images = <Asset>[];
  var detiaLoan;
  @override
  void initState() {
    getCurrencies();
    getLoanProducts();
    setState(() {
      idCcode = widget.list['ccode'];
      selectedValueCustmerName = widget.list['customer'];
      selectedCustomerID.text = widget.list['lcode'];
      lcode = widget.list['lcode'];
      loanController.text = widget.list['lamt'].toString();
      valueAmount = widget.list['lamt'].toString();
      valueNumberofTerm = widget.list['ints'].toString();
      valueInterest = widget.list['intrate'].toString();
      valueMaintenanceFee = widget.list['mfee'].toString();
      valueAdminFee = widget.list['afee'].toString();
      curcode = widget.list['currency'];
      selectedValueCurrencies = widget.list['curcode'];
      pcode = widget.list['loanProduct'];
      selectedValueLoanProduct = widget.list['pcode'];
      numberOfTermController.text = widget.list['ints'].toString();
      interestRateController.text = widget.list['intrate'].toString();
      maintenanceFeeController.text = widget.list['mfee'].toString();
      adminFeeController.text = widget.list['afee'].toString();
      iRRControllers.text = widget.list['irr'].toString();
      repaymentController.text = widget.list['rmode'].toString();
      valueRepaymentMethod = widget.list['rmode'].toString();
      if (widget.list['odate'] != null)
        openDataController.text =
            getDateTimeYMD(widget.list['odate'].toString());
      valueOpenDate = widget.list['odate'];
      if (widget.list['mdate'] != null)
        datehMaturityDateController.text =
            getDateTimeYMD(widget.list['mdate'].toString());
      valueMaturityDate = widget.list['mdate'];
      if (widget.list['expdate'] != null)
        expectedDateController.text =
            getDateTimeYMD(widget.list['expdate'].toString());
      valueFirstRepaymentDate = widget.list['firdate'];
      generateGracePeriodNumberController.text =
          widget.list['graperiod'].toString();
      valueGenerateGracePeriodNumber = widget.list['graperiod'];
      loanPurposeController.text = widget.list['lpourpose'].toString();
      referByWhoController.text = widget.list['refby'].toString();
      valueReferByWho = widget.list['refby'].toString();
      valueORARD = widget.list['lstatus'];
      dscrController.text = widget.list['dscr'].toString();
      lTVController.text = widget.list['ltv'].toString();
      valueLoanPurpose = widget.list['lpourpose'].toString();
      valueDscr = widget.list['dscr'].toString();
      valueLTV = widget.list['ltv'].toString();
      valueRepaymentMethod = widget.list['rmode'];
      // valueORARD = widget.list.loanRequest;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Widget buildGridView() {
  //   return GridView.count(
  //     crossAxisCount: 3,
  //     children: List.generate(images.length, (index) {
  //       Asset asset = images[index];
  //       return AssetThumb(
  //         asset: asset,
  //         width: 300,
  //         height: 300,
  //       );
  //     }),
  //   );
  // }

  // Future<void> loadAssets() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     // Permission.location,
  //     Permission.storage,
  //     Permission.camera,
  //   ].request();

  //   List<Asset>? resultList = <Asset>[];
  //   String error = 'No Error Dectected';
  //   if (await Permission.camera.request().isDenied ||
  //       await Permission.camera.request().isPermanentlyDenied) {
  //     Map<Permission, PermissionStatus> statuses = await [
  //       // Permission.location,
  //       Permission.storage,
  //       Permission.camera,
  //     ].request();
  //   }
  //   if (await Permission.camera.request().isGranted) {
  //     try {
  //       resultList = await MultiImagePicker.pickImages(
  //         maxImages: 300,
  //         enableCamera: true,
  //         selectedAssets: images,
  //         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
  //         materialOptions: MaterialOptions(
  //           actionBarColor: "#abcdef",
  //           actionBarTitle: "Add Image",
  //           allViewTitle: "All Photos",
  //           useDetailsView: false,
  //           selectCircleStrokeColor: "#FFFFFF",
  //         ),
  //       );
  //     } on Exception catch (e) {
  //       error = e.toString();
  //     }

  //     // If the widget was removed from the tree while the asynchronous platform
  //     // message was in flight, we want to discard the reply rather than calling
  //     // setState to update our non-existent appearance.
  //     if (!mounted) return;
  //     setState(() {
  //       images = resultList!;
  //       _error = error;
  //     });
  //   }
  // }

  // List<File>? fileName;
  // loadAssetsFile() async {
  //   if (await Permission.storage.request().isDenied) {
  //     Map<Permission, PermissionStatus> statuses = await [
  //       Permission.storage,
  //     ].request();
  //   }
  //   if (await Permission.storage.request().isGranted) {
  //     try {
  //       // List<File> files = await FilePicker.getMultiFile(
  //       dynamic? files = await FilePicker.platform.pickFiles(
  //         type: FileType.custom,
  //         allowedExtensions: ['jpg', 'pdf', 'doc'],
  //       );
  //       //  type: FileType.custom,
  //       //   allowedExtensions: ['jpg', 'pdf', 'doc'],
  //       setState(() {
  //         fileName = files;
  //       });
  //     } catch (error) {}
  //   }
  // }

  //TEXT INPUT
  var valueAmount;
  var valueNumberofTerm;
  var valueInterest;
  var valueMaintenanceFee;
  var valueAdminFee;
  var valueRepaymentMethod;
  var valueOpenDate;
  var valueMaturityDate;
  var valueFirstRepaymentDate;
  var valueGenerateGracePeriodNumber;
  var valueLoanPurpose;
  var valueORARD;
  var valueReferByWho;
  var selectedValueCustmerName;
  var valueDscr;
  var valueLTV;
  var idCcode;
  var pcode;
  var curcode;
  var lcode;
  var selectedValueCurrencies;
  var selectedValueLoanProduct;

  bool selectedValueCustomer = false;
  bool validateCustomer = false;
  bool validateCurrencies = false;

  final GlobalKey<FormBuilderState> maintenanceFee =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> interestRate =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> numberOfTerm =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> loanAmount = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> adminFee = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> iRRKeys = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> repaymentMethod =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> openData = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> datehMaturityDate =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> firstRepaymentDate =
      GlobalKey<FormBuilderState>();

  final GlobalKey<FormBuilderState> generateGracePeriodNumber =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> loanPurpose = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> oRARD = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> referByWho = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> customerID = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> customerName =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> ltvKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> dscrKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> currenciesKey =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> loanProductsKey =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> expectedDate =
      GlobalKey<FormBuilderState>();

  final TextEditingController selectedCustomerID =
      TextEditingController(text: '');
  //
  final TextEditingController loanController = TextEditingController(text: '');
  final TextEditingController numberOfTermController =
      TextEditingController(text: '');
  final TextEditingController interestRateController =
      TextEditingController(text: '');
  final TextEditingController maintenanceFeeController =
      TextEditingController(text: '');
  final TextEditingController adminFeeController =
      TextEditingController(text: '');
  final TextEditingController repaymentController =
      TextEditingController(text: '');
  final TextEditingController openDataController =
      TextEditingController(text: '');
  final TextEditingController datehMaturityDateController =
      TextEditingController(text: '');
  final TextEditingController expectedDateController =
      TextEditingController(text: '');
  final TextEditingController generateGracePeriodNumberController =
      TextEditingController(text: '');
  final TextEditingController loanPurposeController =
      TextEditingController(text: '');
  final TextEditingController referByWhoController =
      TextEditingController(text: '');
  final TextEditingController dscrController = TextEditingController(text: '');
  final TextEditingController lTVController = TextEditingController(text: '');

  var loanCode;

  Future onSubmit(context) async {
    final storage = new FlutterSecureStorage();
    var user_ucode = await storage.read(key: 'user_ucode');
    var branch = await storage.read(key: 'branch');
    var token = await storage.read(key: 'user_token');

    // var irrInt = double.parse(irr);
    var irrInt = widget.list['irr'];

    var referByWho = valueReferByWho != 'null' ? valueReferByWho : '';
    var curCode =
        selectedValueCurrencies != null ? selectedValueCurrencies : '';
    var expdate = expdateDay != null ? expdateDay : DateTime.now();

    try {
      // final boyrow =
      //     "{\n\t\"ucode\": \"$user_ucode\",\n\t\"lcode\": \"${widget.list['lcode']}\",\n\t\"bcode\": \"$branch\",\n\t\"ccode\": \"$idCcode\",\n\t\"curcode\": \"$curCode\",\n\t\"irr\": $irrInt,\n\t\"expdate\": \"$expdate\",\n\t\"pcode\": \"$selectedValueLoanProduct\",\n\t\"lamt\": $valueAmount,\n\t\"ints\": $valueNumberofTerm,\n\t\"intrate\": $valueInterest,\n\t\"mfee\": $valueMaintenanceFee,\n\t\"afee\": $valueAdminFee,\n\t\"rmode\": \"$valueRepaymentMethod\",\n\t\"odate\": \"${widget.list['odate']}\",\n\t\"mdate\": \"\",\n\t\"firdate\": \"\",\n\t\"graperiod\": $valueGenerateGracePeriodNumber,\n\t\"lpourpose\": \"$valueLoanPurpose\",\n\t\"ltv\": $valueLTV,\n\t\"dscr\": $valueDscr,\n\t\"refby\": \"$referByWho\"}";

      final Map<String, dynamic> boyrow = {
        "ucode": "$user_ucode",
        "lcode": "${widget.list['lcode']}",
        "bcode": "$branch",
        "ccode": "$idCcode",
        "curcode": "$curCode",
        "irr": "$irrInt",
        "expdate": "$expdate",
        "pcode": "$selectedValueLoanProduct",
        "lamt": "$valueAmount",
        "ints": "$valueNumberofTerm",
        "intrate": "$valueInterest",
        "mfee": "$valueMaintenanceFee",
        "afee": "$valueAdminFee",
        "rmode": "$valueRepaymentMethod",
        "odate": "${widget.list['odate']}",
        "mdate": "",
        "firdate": "",
        "graperiod": "$valueGenerateGracePeriodNumber",
        "lpourpose": "$valueLoanPurpose",
        "ltv": "$valueLTV",
        "dscr": "$valueDscr",
        "refby": "$referByWho"
      };
      final Response response = await api().put(
          Uri.parse(baseURLInternal + 'loans/' + widget.list['lcode']),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: json.encode(boyrow));
      final parsed = jsonDecode(response.body);
      setState(() {
        loanCode = parsed;
      });
      if (response.statusCode == 201) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CardDetailLoanRegitration(
                list: lcode,
              ),
            ),
            ModalRoute.withName('/'));
      }
    } catch (error) {
      print('errorgg: $error');
    }
  }

  Future onAddFile(context) async {
    await onSubmit(context);
    if (loanCode != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddReferentDocument(loanCode, "")),
      );
    }
  }

  final numberOfTermFocus = FocusNode();
  final interestRateFocus = FocusNode();
  final maintenanceFeeFocus = FocusNode();
  final adminFeeFocus = FocusNode();
  var generateGracePeriodNumberFocus = FocusNode();
  var loanPurposeFocus = FocusNode();
  var referByWhoFocus = FocusNode();
  var openDataFocus = FocusNode();
  var datehMaturityDateFocus = FocusNode();
  var firstRepaymentDateFocus = FocusNode();
  var loanAmountFocus = FocusNode();
  var lTVFocus = FocusNode();
  var dscrFocus = FocusNode();

  final TextEditingController customerNameControllers = TextEditingController();

  var data = [
    {'name': "Mr.Sea", 'id': '001'},
    {'name': "Mr.SOk", 'id': '002'},
    {'name': "Mr.JOK", 'id': '003'}
  ];
  getList() {
    var mappedCustomerName = data.map((fruit) => '${fruit['name']}').toList();
    return mappedCustomerName;
  }

  var listCurrencies = [];
  getCurrencies() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'user_token');

    try {
      final Response response = await api().get(
        Uri.parse(baseURLInternal + 'valuelists/currencies'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      final list = jsonDecode(response.body);
      setState(() {
        listCurrencies = list;
      });
    } catch (error) {}
  }

  var listLoanProducts = [];
  getLoanProducts() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'user_token');

    try {
      final Response response = await api().get(
        Uri.parse(baseURLInternal + 'valuelists/loanproducts'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      final list = jsonDecode(response.body);
      setState(() {
        listLoanProducts = list;
      });
    } catch (error) {}
  }

  var listCustomers = [];
  getCustomer() async {
    final storage = new FlutterSecureStorage();
    var user_ucode = await storage.read(key: 'user_ucode');
    var token = await storage.read(key: 'user_token');

    try {
      final Response response = await api().get(
        Uri.parse(baseURLInternal + 'valuelists/customers/' + "$user_ucode"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      final list = jsonDecode(response.body);
      setState(() {
        listCustomers = list;
      });
    } catch (error) {}
  }

  final TextEditingController iRRControllers = TextEditingController(text: '');

  var statusEdit;
  var interestIRR;
  var maintenanceFeeIRR;
  var numberofTermIRR;
  var adminFeeIRR;
  var valueIRR;
  var expdateDay;

  iRRCalculation() {
    if (valueNumberofTerm != '0' &&
        valueNumberofTerm != null &&
        valueNumberofTerm != '') {
      var interestIRR;
      var maintenanceFeeIRR;
      var numberofTermIRR;
      var adminFeeIRR;
      var valueIRR;

      interestIRR = valueInterest != null
          ? double.parse(valueInterest)
          : double.parse('0.0');
      maintenanceFeeIRR = valueMaintenanceFee != null
          ? double.parse(valueMaintenanceFee)
          : double.parse('0.0');
      adminFeeIRR = valueAdminFee != null
          ? double.parse(valueAdminFee)
          : double.parse('0.0');
      numberofTermIRR = valueNumberofTerm != null
          ? double.parse(valueNumberofTerm)
          : double.parse('0.0');
      setState(() {
        valueIRR = ((interestIRR + maintenanceFeeIRR) * 12) +
            ((adminFeeIRR / numberofTermIRR) * 12);
        iRRControllers.text = valueIRR.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var percentage = const AssetImage('assets/images/percentage.png');
    var percentages = const AssetImage('assets/images/percentage.png');

    final bool iphonex = MediaQuery.of(context).size.height >= 812.0;
    final double bottomPadding = iphonex ? 16.0 : 0.0;
    return Header(
      headerTexts: 'edit_loans_register',
      actionsNotification: <Widget>[
        // Using Stack to show edit registration
        new Stack(
          children: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.save,
                  size: 25,
                ),
                onPressed: () {
                  if (loanAmount.currentState!.saveAndValidate() &&
                      numberOfTerm.currentState!.saveAndValidate() &&
                      interestRate.currentState!.saveAndValidate() &&
                      maintenanceFee.currentState!.saveAndValidate() &&
                      adminFee.currentState!.saveAndValidate() &&
                      generateGracePeriodNumber.currentState!
                          .saveAndValidate() &&
                      ltvKey.currentState!.saveAndValidate() &&
                      dscrKey.currentState!.saveAndValidate()) {
                    AwesomeDialog(
                        context: context,
                        // animType: AnimType.LEFTSLIDE,
                        headerAnimationLoop: false,
                        dialogType: DialogType.SUCCES,
                        title: AppLocalizations.of(context)!
                                .translate('information') ??
                            'Information',
                        desc: AppLocalizations.of(context)!
                                .translate('do_you_want') ??
                            'Do you want to upload document and submit request?',
                        btnOkOnPress: () async {
                          setState(() {
                            statusEdit = 'add';
                          });
                          await onAddFile(context);
                          logger().e(
                              'selectedValueCustmerName: ${selectedValueCustmerName}');
                        },
                        btnCancelText:
                            AppLocalizations.of(context)!.translate('no') ??
                                "No",
                        btnCancelOnPress: () async {
                          // setState(() {
                          //   statusEdit = 'save';
                          // });
                          // await onSubmit(context);
                        },
                        btnCancelIcon: Icons.close,
                        btnOkIcon: Icons.check_circle,
                        btnOkColor: logolightGreen,
                        btnOkText:
                            AppLocalizations.of(context)!.translate('yes') ??
                                'Yes')
                      ..show();
                  }
                }),
          ],
        ),
      ],
      bodys: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: <Widget>[
              DropDownCustomerRegister(
                icons: Icons.face,
                selectedValue: selectedValueCustmerName,
                validate: validateCustomer
                    ? RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      )
                    : null,
                onInSidePress: () async {
                  await getCustomer();
                  SelectDialog.showModal<String>(
                    context,
                    label: AppLocalizations.of(context)!.translate('Search') ??
                        'Search',
                    items: List.generate(
                        listCustomers.length,
                        (index) =>
                            "${listCustomers[index]['ccode']} - ${listCustomers[index]['namekhr']}"),
                    onChange: (value) async {
                      if (mounted) {
                        setState(() {
                          selectedValueCustmerName = value;
                          selectedValueCustomer = true;
                        });
                        setState(() {
                          idCcode = value.substring(0, 6);
                          selectedCustomerID.text = value.substring(0, 6);
                        });
                      }
                    },
                  );
                },
                clear: false,
                styleTexts: selectedValueCustmerName != ''
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
                texts: selectedValueCustmerName != ''
                    ? selectedValueCustmerName
                    : "customer",
                title: 'customer',
              ),
              GroupFromBuilder(
                icons: Icons.face,
                keys: customerID,
                childs: FormBuilderTextField(
                  name: 'number',
                  controller: selectedCustomerID,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!
                            .translate('customer_id') ??
                        "Customer ID",
                    border: InputBorder.none,
                  ),
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(loanAmountFocus);
                  },
                  onChanged: (v) {
                    if (mounted) {
                      setState(() {
                        valueAmount = v;
                      });
                    }
                  },
                  valueTransformer: (text) {
                    return text == null ? null : text;
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(
                        errorText: AppLocalizations.of(context)!
                                .translate('number_only') ??
                            'Number only')
                  ]),
                  readOnly: true,
                  keyboardType: TextInputType.number,
                ),
              ),
              GroupFromBuilder(
                icons: Icons.check,
                keys: currenciesKey,
                childs: FormBuilderDropdown(
                    name: 'name',
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!
                                .translate('currencies') ??
                            "Currencies",
                        border: InputBorder.none,
                        hintText: curcode ??
                            AppLocalizations.of(context)!
                                .translate('currencies') ??
                            'Currencies',
                        hintStyle: curcode != ''
                            ? TextStyle(color: Colors.black)
                            : TextStyle(color: Colors.grey)),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: AppLocalizations.of(context)!
                                  .translate('currencies_required') ??
                              "Currencies Required(*)"),
                    ]),
                    onChanged: (value) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    items: listCurrencies
                        .map((e) => DropdownMenuItem(
                              value: e['curname'].toString(),
                              onTap: () => {
                                if (mounted)
                                  {
                                    setState(() {
                                      selectedValueCurrencies = e['curcode'];
                                      curcode = e['curcode'];
                                    }),
                                  }
                              },
                              child: Text("${e['curname']}"),
                            ))
                        .toList()),
              ),
              GroupFromBuilder(
                icons: Icons.attach_money,
                keys: loanAmount,
                childs: FormBuilderTextField(
                  name: 'number',
                  autofocus: true,
                  controller: loanController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!
                            .translate('loan_amount') ??
                        'Loan amount',
                    border: InputBorder.none,
                  ),
                  focusNode: loanAmountFocus,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(numberOfTermFocus);
                  },
                  onChanged: (v) {
                    if (mounted) {
                      setState(() {
                        valueAmount = v;
                      });
                    }
                  },
                  valueTransformer: (text) {
                    return text == null ? null : text;
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.min(1),
                    FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!
                                .translate('loan_amount_required') ??
                            "Loan amount Required(*)"),
                    FormBuilderValidators.numeric(
                        errorText: AppLocalizations.of(context)!
                                .translate('number_only') ??
                            'Number only')
                  ]),
                  keyboardType: TextInputType.number,
                ),
              ),
              GroupFromBuilder(
                icons: Icons.check,
                keys: loanProductsKey,
                childs: FormBuilderDropdown(
                  items: listLoanProducts
                      .map((e) => DropdownMenuItem(
                            value: e['pname'].toString(),
                            onTap: () => {
                              if (mounted)
                                {
                                  setState(() {
                                    pcode = e['pcode'];
                                    selectedValueLoanProduct = e['pcode'];
                                  }),
                                }
                            },
                            child: Text("${e['pname']}"),
                          ))
                      .toList(),
                  name: 'name',
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!
                            .translate('loan_products') ??
                        "Loan Products",
                    border: InputBorder.none,
                    hintText: pcode ??
                        AppLocalizations.of(context)!
                            .translate('loan_products') ??
                        'Loan Products',
                    hintStyle: pcode != ''
                        ? TextStyle(color: Colors.black)
                        : TextStyle(color: Colors.grey),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(
                          errorText: AppLocalizations.of(context)!
                                  .translate('loan_products_required') ??
                              "Loan Products Required(*)"),
                    ],
                  ),
                ),
              ),
              GroupFromBuilder(
                icons: Icons.branding_watermark,
                keys: numberOfTerm,
                childs: FormBuilderTextField(
                  name: 'number',
                  controller: numberOfTermController,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(interestRateFocus);
                  },
                  focusNode: numberOfTermFocus,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    // +
                    // '(month*)'
                    labelText: AppLocalizations.of(context)!
                            .translate('number_of_term') ??
                        'Number of term',
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {
                    if (mounted) {
                      setState(() {
                        valueNumberofTerm = v;
                      });
                      iRRCalculation();
                    }
                  },
                  valueTransformer: (text) {
                    return text == null ? null : text;
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!
                                .translate('number_of_term_required') ??
                            "Number of term Required(*)"),
                  ]),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                ),
              ),
              GroupFromBuilder(
                keys: interestRate,
                imageIcon: percentage,
                childs: FormBuilderTextField(
                  name: 'number',
                  focusNode: interestRateFocus,
                  controller: interestRateController,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(maintenanceFeeFocus);
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!
                            .translate('monthly_interest_rate') ??
                        'Monthly interest rate',
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {
                    if (mounted) {
                      setState(() {
                        valueInterest = v;
                      });
                      iRRCalculation();
                    }
                  },
                  valueTransformer: (text) {
                    return text == null ? null : text;
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.min(0.1),
                    FormBuilderValidators.max(1.5),
                    FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!
                                .translate('monthly_interest_rate_required') ??
                            "Monthly interest rate required(*)"),
                  ]),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                ),
              ),
              GroupFromBuilder(
                icons: Icons.attach_money,
                keys: maintenanceFee,
                childs: FormBuilderTextField(
                  name: 'number',
                  controller: maintenanceFeeController,
                  focusNode: maintenanceFeeFocus,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(adminFeeFocus);
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!
                            .translate('maintenance_fee') ??
                        'Maintenance fee',
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {
                    if (mounted) {
                      setState(() {
                        valueMaintenanceFee = v;
                      });
                      iRRCalculation();
                    }
                  },
                  valueTransformer: (text) {
                    return text == null ? null : text;
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.max(0.7),
                    FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!
                                .translate('maintenance_fee_required') ??
                            "Maintenance fee required(*)"),
                  ]),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                ),
              ),
              GroupFromBuilder(
                icons: Icons.attach_money,
                keys: adminFee,
                childs: FormBuilderTextField(
                  name: 'number',
                  focusNode: adminFeeFocus,
                  controller: adminFeeController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.translate('admin_fee') ??
                            'Admin fee',
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {
                    if (mounted) {
                      setState(() {
                        valueAdminFee = v;
                      });
                      iRRCalculation();
                    }
                  },
                  valueTransformer: (text) {
                    return text == null ? null : text;
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.max(2),
                    FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!
                                .translate('admin_fee_required') ??
                            "Admin fee required(*)"),
                  ]),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                ),
              ),
              GroupFromBuilder(
                imageIcon: percentages,
                keys: iRRKeys,
                childs: FormBuilderTextField(
                  controller: iRRControllers,
                  readOnly: true,
                  name: 'number',
                  focusNode: dscrFocus,
                  decoration: InputDecoration(
                    labelText: 'IRR',
                    border: InputBorder.none,
                  ),
                  valueTransformer: (text) {
                    return text == null ? null : text;
                  },
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!
                                .translate('irr_required') ??
                            "IRR required(*)"),
                  ]),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              GroupFromBuilder(
                icons: Icons.check,
                keys: repaymentMethod,
                childs: FormBuilderDropdown(
                  name: 'name',
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!
                            .translate('repayment_method') ??
                        "Repayment method",
                    border: InputBorder.none,
                    hintText: valueRepaymentMethod ??
                        AppLocalizations.of(context)!
                            .translate('repayment_method'),
                    hintStyle: valueRepaymentMethod != ''
                        ? TextStyle(color: Colors.black)
                        : TextStyle(color: Colors.grey),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (value) {
                    if (mounted) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() => valueRepaymentMethod = value);
                    }
                  },
                  items: [
                    'Declining',
                    'Annuity',
                    'Semi-balloon',
                    'Balloon',
                    'Negotiate',
                  ]
                      .map((v) => DropdownMenuItem(
                          value: v,
                          child: Text(
                            "$v",
                          )))
                      .toList(),
                ),
              ),
              GroupFromBuilder(
                icons: Icons.date_range,
                keys: expectedDate,
                childs: FormBuilderDateTimePicker(
                  name: "",
                  focusNode: firstRepaymentDateFocus,
                  controller: expectedDateController,
                  textInputAction: TextInputAction.next,
                  inputType: InputType.date,
                  firstDate: DateTime.now(),
                  onChanged: (v) {
                    if (mounted) {
                      setState(() {
                        expdateDay = v;
                      });
                      FocusScope.of(context)
                          .requestFocus(generateGracePeriodNumberFocus);
                    }
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!
                                .translate('expected_date_required') ??
                            "Expected date required(*)"),
                  ]),
                  // initialValue: DateTime(
                  //   now.year,
                  //   now.month,
                  //   now.day + 15,
                  // ),
                  format: DateFormat("yyyy-MM-dd"),
                  decoration: InputDecoration(
                    labelText: widget.list['expdate'] != null &&
                            widget.list['expdate'] != ''
                        ? getDateTimeYMD(widget.list['expdate'])
                        : AppLocalizations.of(context)!
                                .translate('expected_date') ??
                            "Expected date(*)",
                    border: InputBorder.none,
                  ),
                ),
              ),
              GroupFromBuilder(
                icons: Icons.confirmation_number,
                keys: generateGracePeriodNumber,
                childs: FormBuilderTextField(
                  name: 'number',
                  controller: generateGracePeriodNumberController,
                  focusNode: generateGracePeriodNumberFocus,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(loanPurposeFocus);
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!
                            .translate('generate_grace_period_number') ??
                        'Generate ',
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {
                    valueGenerateGracePeriodNumber = v;
                  },
                  valueTransformer: (text) {
                    return text == null ? null : text;
                  },
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                    // WhitelistingTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              GroupFromBuilder(
                icons: Icons.attach_money,
                keys: loanPurpose,
                childs: FormBuilderTextField(
                  name: 'name',
                  focusNode: loanPurposeFocus,
                  controller: loanPurposeController,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(referByWhoFocus);
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!
                            .translate('loan_purpose') ??
                        'Loan purpose',
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {
                    valueLoanPurpose = v;
                  },
                  valueTransformer: (text) {
                    return text == null ? null : text;
                  },
                  keyboardType: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!
                                .translate('loan_purpose_required') ??
                            "Loan purpose required(*)"),
                  ]),
                ),
              ),
              GroupFromBuilder(
                icons: Icons.confirmation_number,
                keys: ltvKey,
                childs: FormBuilderTextField(
                  name: 'number',
                  controller: lTVController,
                  focusNode: lTVFocus,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(dscrFocus);
                  },
                  decoration: const InputDecoration(
                    labelText: 'LTV',
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {
                    if (mounted) {
                      setState(() {
                        valueLTV = v;
                      });
                    }
                  },
                  valueTransformer: (text) {
                    return text == null ? null : text;
                  },
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.max(0.9)
                  ]),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                    // WhitelistingTextInputFormatter(
                    //     RegExp(r'^(\d+)?\.?\d{0,2}')),
                  ],
                ),
              ),
              GroupFromBuilder(
                icons: Icons.confirmation_number,
                keys: dscrKey,
                childs: FormBuilderTextField(
                  name: 'number',
                  controller: dscrController,
                  focusNode: dscrFocus,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(referByWhoFocus);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Dscr',
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {
                    if (mounted) {
                      setState(() {
                        valueDscr = v;
                      });
                    }
                  },
                  valueTransformer: (text) {
                    return text == null ? null : text;
                  },
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.min(0),
                  ]),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                    // WhitelistingTextInputFormatter(
                    //     RegExp(r'^(\d+)?\.?\d{0,2}')),
                  ],
                ),
              ),
              GroupFromBuilder(
                icons: Icons.face,
                keys: referByWho,
                childs: FormBuilderTextField(
                  name: 'name',
                  focusNode: referByWhoFocus,
                  controller: referByWhoController,
                  textInputAction: TextInputAction.next,
                  // onFieldSubmitted: (v) {
                  //   FocusScope.of(context).requestFocus(repaymentMethodFocus);
                  // },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!
                            .translate('refer_by_who') ??
                        'Refer by who',
                    border: InputBorder.none,
                  ),
                  onChanged: (v) {
                    valueReferByWho = v;
                  },
                  valueTransformer: (text) {
                    return text == null ? null : text;
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
              AnimatedButton(
                text: AppLocalizations.of(context)!.translate('save') ?? 'Save',
                color: logolightGreen,
                pressEvent: () {
                  if (loanAmount.currentState!.saveAndValidate() &&
                      numberOfTerm.currentState!.saveAndValidate() &&
                      interestRate.currentState!.saveAndValidate() &&
                      maintenanceFee.currentState!.saveAndValidate() &&
                      adminFee.currentState!.saveAndValidate() &&
                      generateGracePeriodNumber.currentState!
                          .saveAndValidate() &&
                      ltvKey.currentState!.saveAndValidate() &&
                      dscrKey.currentState!.saveAndValidate()) {
                    AwesomeDialog(
                        context: context,
                        // animType: AnimType.LEFTSLIDE,
                        headerAnimationLoop: false,
                        dialogType: DialogType.SUCCES,
                        title: AppLocalizations.of(context)!
                                .translate('information') ??
                            'Information',
                        desc: AppLocalizations.of(context)!
                                .translate('do_you_want') ??
                            'Do you want to upload document and submit request?',
                        btnOkOnPress: () async {
                          setState(() {
                            statusEdit = 'edit';
                          });
                          await onAddFile(context);
                        },
                        btnCancelText:
                            AppLocalizations.of(context)!.translate('no') ??
                                "No",
                        btnCancelOnPress: () async {
                          // setState(() {
                          //   statusEdit = 'save';
                          // });
                          // await onSubmit(context);
                        },
                        btnCancelIcon: Icons.close,
                        btnOkIcon: Icons.check_circle,
                        btnOkColor: logolightGreen,
                        btnOkText:
                            AppLocalizations.of(context)!.translate('yes') ??
                                'Yes')
                      ..show();
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(bottom: bottomPadding))
            ],
          ),
        ),
      ),
    );
  }
}
