import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/storages/colors.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final bool isValidate;
  final String? labelText, hinText;
  // final CustomeDatePicker disposition;
  CustomDatePicker({
    super.key,
    required this.controller,
    this.isValidate = false,
    this.labelText,
    this.hinText,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  // TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: TextFormField(
          onTap: () {
            onShowDateTimePicker(
              controller: widget.controller,
              context: context,
            );
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     (value.toString());
          //     return 'Please select date *';
          //   }
          //   return null;
          // },
          onChanged: (v) {
            // FocusScope.of(context).unfocus(disposition: disposition);
          },
          controller: widget.controller,
          textInputAction: TextInputAction.next,
          // key: _formDateTextFromFieldkey,
          decoration: new InputDecoration(
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.8,
                  color: widget.isValidate == true
                      ? Colors.red
                      : AppColors.logoDarkBlue,
                ),
                borderRadius: BorderRadius.circular(15.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.8,
                  color: widget.isValidate == true &&
                          widget.controller.text.isEmpty
                      ? Colors.red
                      : AppColors.logoDarkBlue,
                ),
                borderRadius: BorderRadius.circular(15.0)),
            labelText: widget.labelText,
            hintText: widget.hinText,
            suffixIcon: InkWell(
              child: Icon(
                Icons.calendar_today,
              ),
            ),
            hintStyle: TextStyle(
              color: AppColors.logoDarkBlue.withOpacity(0.7),
            ),
            labelStyle: TextStyle(
                // color: AppColors.logoDarkBlue,
                color: Colors.black54),
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
              borderSide: new BorderSide(),
            ),
          ),
        ),
      ),
    );
  }

  onShowDateTimePicker(
      {TextEditingController? controller, BuildContext? context}) async {
    await showDatePicker(
      locale: Locale('en', 'IN'),
      context: context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      fieldHintText: 'dd-MM-yyyy',
      initialEntryMode: DatePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              secondary: Colors.white,
              onPrimary: Colors.white,
              onSurface: logoDarkBlue,
              primary: logolightGreen,
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
                backgroundColor: logoDarkBlue,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: logolightGreen,
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((selectedDate) {
      if (selectedDate != null) {
        if (mounted)
          // setState(() {
          controller!.text = DateFormat('yyyy-MM-dd').format(selectedDate);
        // });
      }
    });
  }
}
