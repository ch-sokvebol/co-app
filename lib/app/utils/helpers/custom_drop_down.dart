import 'dart:async';
import 'package:chokchey_finance/app/module/loan_arrear/controllers/loan_arrear_controller.dart';
import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:chokchey_finance/app/utils/helpers/date_time_picker.dart';
import 'package:chokchey_finance/app/utils/helpers/dropdow_item.dart';
import 'package:chokchey_finance/app/utils/helpers/showbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../localizations/appLocalizations.dart';
import '../../module/util/widget/custom_textfield.dart';

//==
class CustomDropDown extends StatefulWidget {
  final String? otherLabel;
  final bool? isNoRequired;
  final List<DropDownItem>? item;
  final GestureTapCallback? onTap;
  final String? label;
  final ValueChanged<Map>? onChange;
  final bool? validate;
  final Map? defaultValue;
  final bool? isDateTimePicker;
  final bool? isValidate;
  final bool? isSelectMember;
  final bool? isCompany;
  final bool? isSelectBank;
  final bool? isEnable;
  final bool? isProfile;
  final Function? onCreateCompany;
  final bool isUserAccount;
  final EdgeInsets? isPadding;
  final String? imageUrl;
  final Color? colors;
  final bool? isPayment;
  final EdgeInsets? marginAddNew;
  final bool isIconCalendar;
  final EdgeInsets? paddingSuffixIcon;
  final EdgeInsets? margin;
  final bool? isAppBar;
  final bool? getDateTime;
  final DateTime? currentDate;
  final String? title;
  final ValueChanged<String>? onChangeSearch;
  final bool? isSearchButton;
  final String? hintSearch;
  final bool? isLoandingItem;
  final bool? isSearchUserStatic;
  final Color? borderColor;
  final double? borderWith;
  final GestureTapCallback? onLeading;
  final Color? labelColor;
  final bool? isDateTime;

  const CustomDropDown({
    Key? key,
    this.isNoRequired = false,
    this.currentDate,
    this.marginAddNew,
    this.margin,
    this.isAppBar = false,
    this.paddingSuffixIcon,
    this.isEnable = false,
    this.onCreateCompany,
    this.item,
    this.onChange,
    this.isProfile = false,
    required this.label,
    this.validate = false,
    this.isDateTimePicker = false,
    this.defaultValue,
    this.isSelectMember = false,
    this.isCompany = false,
    this.isSelectBank = false,
    this.isUserAccount = false,
    this.isPadding,
    this.imageUrl,
    this.colors,
    this.isValidate,
    this.isPayment = false,
    this.isIconCalendar = true,
    this.getDateTime = false,
    this.otherLabel,
    this.onTap,
    this.title,
    this.onChangeSearch,
    this.isSearchButton = false,
    this.hintSearch,
    this.isLoandingItem = false,
    this.isSearchUserStatic = false,
    this.borderColor,
    this.borderWith = 1,
    this.onLeading,
    this.labelColor,
    this.isDateTime = false,
  }) : super(key: key);
  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  Map? selectData = {};
  Map? copyData = {};
  int? currentIndex;
  String? dateTime;
  bool isLoading = false;
  Future? memberListFuture;
  int page = 1;
  int searchPage = 1;
  bool isLoadingMore = false;
  String searchFilter = '';
  String pageName = 'memberList';
  bool isFecthMoredata = false;

  @override
  void initState() {
    setState(
      () {
        selectData = {'Name': '${widget.label}', 'Code': '02'};
      },
    );

    super.initState();
  }

  final con = Get.put(LoanArrearController());

  @override
  Widget build(BuildContext context) {
    if (widget.defaultValue != null) {
      copyData = widget.defaultValue!;
    } else {
      copyData = selectData;
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        widget.isDateTime == true
            ? openDateTimePicker(
                context: context,
                currentDate: widget.currentDate,
                getDateTimeFormat: widget.getDateTime,
                onSelectDone: (date) {
                  // setState(() {
                  //   copyData = {
                  //       'Name': dateTime,
                  //         'Code': '01',
                  //   };

                  // });
                  widget.onChange!({
                    'Name': date,
                    'Code': '01',
                  });
                })
            : onShowCustomCupertinoModalSheet(
                onLeading: widget.onLeading ??
                    () {
                      Navigator.pop(context);
                    },
                context: context,
                title: '',
                dynamicTitle: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 30),
                  child: Text(
                    '${widget.label}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                // shape:
                //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  // margin: widget.margin ??
                  //     const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor),
                  child: Stack(
                    children: [
                      widget.isSearchButton == true
                          ? Container(
                              // width: 200,
                              // height: 90,
                              padding: const EdgeInsets.only(
                                  right: 20, top: 15, left: 20),
                              // margin: const EdgeInsets.only(left: 10),
                              child: CustomTextFieldNew(
                                labelText: widget.label,
                                hintText: '${widget.hintSearch}',
                                prefixIcon: Icon(
                                  Icons.search,
                                  // color: AppColors.logolightGreen,
                                ),
                                borderColor:
                                    AppColors.logolightGreen.withOpacity(0.4),
                                onChange: widget.onChangeSearch,
                                hinTextColor: Colors.black54,
                              ),
                            )
                          : Container(),
                      // Container(
                      //   margin: EdgeInsets.only(top: 10),
                      //   height: 5,
                      //   width: 30,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: Colors.grey[300]),
                      // ),

                      // if (widget.isSearchButton == false)
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20, top: 20),
                      //   child: Text('${widget.label}',
                      //       style: Theme.of(context).textTheme.titleLarge),
                      // ),
                      // if (widget.isSearchButton == false)
                      //   Positioned(
                      //     top: 60,
                      //     left: 0,
                      //     right: 0,
                      //     child: Divider(
                      //       thickness: 1,
                      //       color: Colors.grey[300],
                      //     ),
                      //   ),

                      widget.isSearchUserStatic == true
                          ? onSearchUser()
                          : Positioned(
                              top: 20,
                              left: 20,
                              right: 20,
                              bottom: 20,
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    // indent: 35,
                                    thickness: 1,
                                    color: Colors.grey[300],
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      widget.onChange!(
                                          widget.item![index].itemList!);
                                      // setState(() {
                                      //   currentIndex = index;
                                      //   copyData = {
                                      //     'Name': widget
                                      //         .item![index].itemList!['Name'],
                                      //     'Code': widget
                                      //         .item![index].itemList!['Code'],
                                      //   };
                                      // });
                                    },
                                    child: DropDownItem(
                                      isPadding: widget.isPadding,
                                      isUserAccount: widget.isUserAccount,
                                      profile: widget.isProfile,
                                      isSelect: currentIndex == index,
                                      paddingSuffixIcon:
                                          widget.paddingSuffixIcon,
                                      itemList: {
                                        'Name': widget
                                            .item![index].itemList!['Name'],
                                        'Code': widget
                                            .item![index].itemList!['Code'],
                                        'accountName': widget.item![index]
                                            .itemList!['accountName'],
                                        'accountNumber': widget.item![index]
                                            .itemList!['accountNumber'],
                                        'picture': widget
                                            .item![index].itemList!['picture'],
                                        'datePayment': widget.item![index]
                                            .itemList!['datePayment'],
                                        'title': widget
                                            .item![index].itemList!['title']
                                      },
                                    ),
                                  );
                                },
                                itemCount: widget.item!.length,
                              ),
                            ),
                    ],
                  ),
                ),
              );
      },
      child: SizedBox(
        child: Stack(
          children: [
            widget.isValidate == false
                ? SizedBox(
                    height: 68,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        const SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        Positioned(
                          top: 10,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            alignment: Alignment.centerLeft,
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: widget.borderWith!,
                                    color: widget.borderColor ??
                                        AppColors.logolightGreen)),
                            child: Row(
                              children: [
                                widget.defaultValue != null
                                    ? Expanded(
                                        child: Text('${copyData!['Name']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            overflow: TextOverflow.ellipsis),
                                      )
                                    : Text('${copyData!['Name']}',
                                        style: copyData == selectData
                                            ? Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    color: widget.labelColor ??
                                                        Colors.grey)
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                        overflow: TextOverflow.ellipsis),
                                if (widget.defaultValue == null) const Spacer(),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: copyData != selectData
                                      ? Theme.of(context).primaryColor
                                      : Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (widget.defaultValue != null)
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              margin: EdgeInsets.only(left: 35, top: 2),
                              color: Colors.white,
                              child: Text(
                                '${widget.label}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontSize: 12,
                                    ),
                              )),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 68,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        const SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        Positioned(
                          top: 10,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            alignment: Alignment.centerLeft,
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1.8,
                                color: widget.isValidate == true
                                    ? Colors.red
                                    : AppColors.logoDarkBlue,
                              ),
                            ),
                            child: Row(
                              children: [
                                widget.defaultValue != null
                                    ? Expanded(
                                        child: Text('${copyData!['Name']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            overflow: TextOverflow.ellipsis),
                                      )
                                    : Text('${copyData!['Name']} *',
                                        style: copyData == selectData
                                            ? Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    color: widget.labelColor ??
                                                        Colors.grey)
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                        overflow: TextOverflow.ellipsis),
                                if (widget.defaultValue == null) const Spacer(),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: copyData != selectData
                                      ? Theme.of(context).primaryColor
                                      : Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            widget.isValidate == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 70, left: 30),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate('error')}",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////
  Widget onSearchUser() {
    return Obx(
      () => con.isLoadingSearch.value == true
          ? Center(
              child: SpinKitFadingCircle(
              color: Colors.black26,
            ))
          : Positioned(
              top: 75,
              left: 20,
              right: 20,
              bottom: 40,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    // indent: 35,
                    thickness: 1,
                    color: Colors.grey[300],
                  );
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      widget.onChange!(widget.item![index].itemList!);
                      // setState(() {
                      //   currentIndex = index;
                      //   copyData = {
                      //     'Name': widget
                      //         .item![index].itemList!['Name'],
                      //     'Code': widget
                      //         .item![index].itemList!['Code'],
                      //   };
                      // });
                    },
                    child: DropDownItem(
                      isPadding: widget.isPadding,
                      isUserAccount: widget.isUserAccount,
                      profile: widget.isProfile,
                      isSelect: currentIndex == index,
                      paddingSuffixIcon: widget.paddingSuffixIcon,
                      itemList: {
                        'Name': widget.item![index].itemList!['Name'],
                        'Code': widget.item![index].itemList!['Code'],
                        'accountName':
                            widget.item![index].itemList!['accountName'],
                        'accountNumber':
                            widget.item![index].itemList!['accountNumber'],
                        'picture': widget.item![index].itemList!['picture'],
                        'datePayment':
                            widget.item![index].itemList!['datePayment'],
                        'title': widget.item![index].itemList!['title']
                      },
                    ),
                  );
                },
                itemCount: widget.item!.length,
              ),
            ),
    );
  }
}
