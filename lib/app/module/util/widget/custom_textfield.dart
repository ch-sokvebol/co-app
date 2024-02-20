import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../localizations/appLocalizations.dart';
import '../../../utils/colors/app_color.dart';

class CustomTextFieldNew extends StatefulWidget {
  final List<TextInputFormatter>? inputFormatterList;
  final String? initialValue;
  final String? validateText;
  final ValueChanged<String>? onChange;
  final String? labelText;
  final String? hintText;
  final String? type;
  final FormFieldValidator<String>? validate;
  final Function? onTap;
  final FormFieldSetter<String>? onSave;
  final TextInputType? keyboardType;
  final int? maxLine;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isRequired;
  final bool? isValidate;
  final bool? isReadOnly;
  final bool? autoFocus;
  final TextEditingController? controller;
  final VoidCallback? onEditingComplete;
  final bool? enable;
  final bool? isObscureText;
  final bool? isVisibilitySize;
  final TextInputAction? textInputAction;
  final int? maxlenght;
  final EdgeInsets? scrollPadding;
  final Border? borderFacus;
  final double? cursorHeight;
  final double? cursorWidth;
  final bool? isMeter;
  final FocusNode? focusNode;
  final Color? borderColor;
  final Color? hinTextColor;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? obscureText;
  final Color? labelColor;

  // ignore: prefer_const_constructors_in_immutables
  CustomTextFieldNew(
      {this.prefixIcon,
      this.cursorHeight,
      this.isObscureText = false,
      this.scrollPadding,
      this.cursorWidth,
      this.focusNode,
      this.maxlenght,
      this.isMeter = false,
      this.isVisibilitySize,
      this.inputFormatterList,
      this.validateText,
      this.onEditingComplete,
      Key? key,
      this.isReadOnly,
      this.controller,
      this.initialValue,
      this.onChange,
      this.labelText,
      this.hintText,
      this.type,
      this.validate,
      this.onTap,
      this.autoFocus,
      this.onSave,
      this.keyboardType,
      this.maxLine = 1,
      this.suffixIcon,
      this.isRequired,
      this.isValidate = false,
      this.textInputAction,
      this.enable = true,
      this.borderFacus,
      this.borderColor,
      this.hinTextColor,
      this.onFieldSubmitted,
      this.obscureText = false,
      this.labelColor})
      : super(key: key);

  @override
  State<CustomTextFieldNew> createState() => _CustomTextFieldNewState();
}

class _CustomTextFieldNewState extends State<CustomTextFieldNew> {
  Color borderColor = Colors.grey;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          textAlignVertical: TextAlignVertical.top,
          obscureText: widget.obscureText!,
          onFieldSubmitted: widget.onFieldSubmitted,
          cursorWidth: 2,
          cursorHeight: widget.cursorHeight,
          inputFormatters: widget.inputFormatterList,
          onEditingComplete: widget.onEditingComplete,
          controller: widget.controller,
          maxLength: widget.maxlenght,
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          maxLines: widget.maxLine,
          validator: widget.validate,
          initialValue: widget.controller == null ? widget.initialValue : null,
          onChanged: widget.onChange,
          onSaved: widget.onSave,
          keyboardType: widget.keyboardType,
          showCursor: true,
          enabled: widget.enable,
          readOnly: widget.isReadOnly ?? false,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            label: Text(
              '${widget.labelText}',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                    color: widget.labelColor ?? Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1.8,
                  color: widget.isValidate == true
                      ? Colors.red
                      : AppColors.logolightGreen),
            ),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1.8,
                color: widget.isValidate == true
                    ? Colors.red
                    : widget.borderColor ?? AppColors.logolightGreen,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1.8,
                  color: widget.isValidate == true
                      ? Colors.red
                      : AppColors.logolightGreen),
            ),
            counterText: '',
            suffixIcon: widget.suffixIcon != null ? widget.suffixIcon! : null,
            prefixIcon: widget.prefixIcon != null ? widget.prefixIcon! : null,
            hintText: widget.hintText ?? '',
            labelStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black54, fontWeight: FontWeight.w400),
            hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: widget.hinTextColor ??
                    AppColors.logoDarkBlue.withOpacity(
                      0.7,
                    ),
                fontWeight: FontWeight.w400),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          focusNode: widget.focusNode,
        ),
        widget.isValidate == true
            ? Padding(
                padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
                child: Text(
                  "${AppLocalizations.of(context)!.translate('error')}",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
