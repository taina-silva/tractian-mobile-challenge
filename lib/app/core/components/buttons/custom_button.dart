import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tractian_mobile_challenge/app/core/utils/constants.dart';
import 'package:tractian_mobile_challenge/app/core/utils/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final ButtonParameters params;
  final ButtonType type;

  const CustomButton._(this.params, this.type);

  factory CustomButton.primarySmall(ButtonParameters params) {
    return CustomButton._(params.copyWith(fSize: FSize.small), ButtonType.primary);
  }

  factory CustomButton.primaryRegular(ButtonParameters params) {
    return CustomButton._(params.copyWith(fSize: FSize.regular), ButtonType.primary);
  }

  factory CustomButton.primaryBig(ButtonParameters params) {
    return CustomButton._(params.copyWith(fSize: FSize.big), ButtonType.primary);
  }

  factory CustomButton.secondarySmall(ButtonParameters params) {
    return CustomButton._(params.copyWith(fSize: FSize.small), ButtonType.secondary);
  }

  factory CustomButton.secondaryRegular(ButtonParameters params) {
    return CustomButton._(params.copyWith(fSize: FSize.regular), ButtonType.secondary);
  }

  factory CustomButton.secondaryBig(ButtonParameters params) {
    return CustomButton._(params.copyWith(fSize: FSize.big), ButtonType.secondary);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !params.isDisabled && !params.isLoading ? params.onTap : null,
      child: Container(
        height: params.height,
        width: params.width,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Layout.borderRadiusSmall),
          color: _backgroundColor,
          border: Border.all(
            width: 1,
            color: _borderColor,
          ),
        ),
        child: params.isLoading ? _buttonLoading : _buttonContent,
      ),
    );
  }

  Widget get _buttonLoading {
    return Center(
      child: SizedBox(
        height: params.height / 2,
        width: params.height / 2,
        child: CircularProgressIndicator(
          color: _contentColor,
          strokeWidth: params.height / 15,
        ),
      ),
    );
  }

  Widget get _buttonContent {
    List<Widget> content = [
      if (params.prefixIcon != null) ...[
        params.prefixIcon!.fold(
          (icon) => Icon(
            icon,
            size: params.iconsSize,
            color: _contentColor,
          ),
          (widget) => widget,
        ),
        const SizedBox(width: 8),
      ],
      Center(
        child: Text(
          params.text,
          style: TextStyle(
            fontSize: params.fSize,
            fontWeight: params.fWeight,
            color: _contentColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      if (params.suffixIcon != null) ...[
        const SizedBox(width: 8),
        params.suffixIcon!.fold(
          (icon) => Icon(
            icon,
            size: params.iconsSize,
            color: _contentColor,
          ),
          (widget) => widget,
        ),
      ],
    ];

    return Container(
      margin: EdgeInsets.only(
        left: params.contentAlignment == ButtonContentAlignment.left ? 20 : 0,
        right: params.contentAlignment == ButtonContentAlignment.right ? 20 : 0,
      ),
      child: Row(
        mainAxisAlignment: () {
          switch (params.contentAlignment) {
            case ButtonContentAlignment.left:
              return MainAxisAlignment.start;
            case ButtonContentAlignment.right:
              return MainAxisAlignment.end;
            case ButtonContentAlignment.center:
              return MainAxisAlignment.center;
            default:
              return MainAxisAlignment.center;
          }
        }(),
        children: content,
      ),
    );
  }

  Color get _backgroundColor {
    switch (type) {
      case ButtonType.primary:
        if (params.isDisabled) return CColors.neutral300;
        return CColors.secondaryColor;

      case ButtonType.secondary:
        if (params.isDisabled) return CColors.neutral300;
        return CColors.neutral0;
    }
  }

  Color get _borderColor {
    switch (type) {
      case ButtonType.primary:
        return Colors.transparent;
      case ButtonType.secondary:
        if (params.isDisabled) return CColors.neutral500;
        return CColors.neutral900;
    }
  }

  Color get _contentColor {
    switch (type) {
      case ButtonType.primary:
        if (params.isDisabled) return CColors.neutral700;
        return CColors.neutral0;
      case ButtonType.secondary:
        if (params.isDisabled) return CColors.neutral500;
        return CColors.neutral900;
    }
  }
}

enum ButtonType { primary, secondary }

enum ButtonContentAlignment { left, center, right }

class ButtonParameters extends Equatable {
  final String text;
  final double fSize;
  final FontWeight fWeight;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final int maxLines;
  final Either<IconData, Widget>? prefixIcon;
  final Either<IconData, Widget>? suffixIcon;
  final double iconsSize;
  final bool isDisabled;
  final bool isLoading;
  final ButtonContentAlignment? contentAlignment;

  const ButtonParameters({
    required this.text,
    this.fSize = FSize.small,
    this.fWeight = FWeight.bold,
    this.onTap,
    this.width = double.infinity,
    this.height = 52,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.iconsSize = 20,
    this.isLoading = false,
    this.isDisabled = false,
    this.contentAlignment = ButtonContentAlignment.center,
  });

  ButtonParameters copyWith({
    String? text,
    double? fSize,
    FontWeight? fWeight,
    bool? isLoading,
    VoidCallback? onTap,
    double? width,
    double? height,
    int? maxLines,
    Either<IconData, Widget>? prefixIcon,
    Either<IconData, Widget>? suffixIcon,
    bool? isDisabled,
    double? iconsSize,
    bool? displayAsColumn,
    Color? overrideBackgroundColor,
    ButtonContentAlignment? contentAlignment,
  }) {
    return ButtonParameters(
      text: text ?? this.text,
      fSize: fSize ?? this.fSize,
      fWeight: fWeight ?? this.fWeight,
      isLoading: isLoading ?? this.isLoading,
      onTap: onTap ?? this.onTap,
      width: width ?? this.width,
      height: height ?? this.height,
      maxLines: maxLines ?? this.maxLines,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      isDisabled: isDisabled ?? this.isDisabled,
      iconsSize: iconsSize ?? this.iconsSize,
      contentAlignment: contentAlignment ?? this.contentAlignment,
    );
  }

  @override
  List<Object?> get props => [
        text,
        fSize,
        fWeight,
        isLoading,
        onTap,
        width,
        height,
        maxLines,
        prefixIcon,
        suffixIcon,
        isDisabled,
        iconsSize,
        contentAlignment,
      ];
}
