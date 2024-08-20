import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tractian_mobile_challenge/app/core/utils/constants.dart';
import 'package:tractian_mobile_challenge/app/core/utils/custom_colors.dart';

enum FieldDecoration {
  focusedBorder,
  enabledBorder,
  errorBorder,
  focusedErrorBorder;

  const FieldDecoration();

  OutlineInputBorder get style {
    switch (this) {
      case focusedBorder:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(Layout.borderRadiusSmall),
          borderSide: const BorderSide(
            width: 1,
            color: CColors.neutral900,
          ),
        );
      case enabledBorder:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(Layout.borderRadiusSmall),
          borderSide: const BorderSide(
            width: 1,
            color: CColors.neutral350,
          ),
        );
      case errorBorder:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(Layout.borderRadiusSmall),
          borderSide: const BorderSide(
            width: 1,
            color: CColors.error500,
          ),
        );
      case focusedErrorBorder:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(Layout.borderRadiusSmall),
          borderSide: const BorderSide(
            width: 1,
            color: CColors.error500,
          ),
        );
    }
  }
}

class CommonField extends StatelessWidget {
  final void Function(String)? onChange;
  final TextEditingController? controller;
  final String placeholder;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final bool obscure;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool autoCorret;
  final bool autofocus;
  final bool expands;
  final TextInputAction? inputAction;
  final void Function(String)? onSubmit;
  final String? initialValue;
  final bool readOnly;
  final VoidCallback? onTap;
  final EdgeInsets scrollPadding;
  final FontStyle? placeHolderFontStyle;
  final FocusNode? focusNode;
  final double fontSize;
  final double cursorHeight;
  final EdgeInsets contentPadding;
  final TextAlignVertical textAlignVertical;
  final bool disableBorder;
  final Color fillColor;

  const CommonField({
    super.key,
    this.onChange,
    this.placeHolderFontStyle,
    this.controller,
    this.placeholder = '',
    this.inputFormatters = const [],
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.suffixIcon,
    this.autoCorret = false,
    this.autofocus = false,
    this.expands = false,
    this.inputAction,
    this.onSubmit,
    this.initialValue,
    this.readOnly = false,
    this.prefixIcon,
    this.onTap,
    this.focusNode,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.fontSize = 16,
    this.cursorHeight = 20,
    this.contentPadding = const EdgeInsets.only(left: 10, top: 10, right: 44, bottom: 10),
    this.textAlignVertical = TextAlignVertical.center,
    this.disableBorder = false,
    this.fillColor = CColors.neutral0,
  }) : assert(
          initialValue == null || controller == null,
          'You cannot pass initialValue AND controller at the same time',
        );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: expands,
      maxLines: expands ? null : 1,
      focusNode: focusNode,
      scrollPadding: scrollPadding,
      onTap: onTap,
      cursorHeight: cursorHeight,
      onFieldSubmitted: onSubmit,
      textInputAction: inputAction,
      textAlignVertical: textAlignVertical,
      controller: controller,
      onChanged: onChange,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      obscureText: obscure,
      cursorColor: CColors.primaryColor,
      validator: validator,
      autovalidateMode: autovalidateMode,
      autocorrect: autoCorret,
      autofocus: autofocus,
      readOnly: readOnly,
      style: TextStyle(fontSize: fontSize, color: CColors.primaryColor),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding,
        filled: true,
        fillColor: fillColor,
        errorStyle: const TextStyle(color: Colors.red),
        hintText: placeholder,
        hintStyle: TextStyle(
          color: CColors.neutral350,
          fontSize: 20,
          fontStyle: placeHolderFontStyle ?? FontStyle.italic,
        ),
        focusedBorder: disableBorder ? InputBorder.none : FieldDecoration.focusedBorder.style,
        enabledBorder: disableBorder ? InputBorder.none : FieldDecoration.enabledBorder.style,
        errorBorder: disableBorder ? InputBorder.none : FieldDecoration.errorBorder.style,
        focusedErrorBorder:
            disableBorder ? InputBorder.none : FieldDecoration.focusedErrorBorder.style,
      ),
    );
  }
}
