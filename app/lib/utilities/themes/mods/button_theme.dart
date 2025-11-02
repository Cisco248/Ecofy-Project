import 'package:e_wms_mobile/utilities/constants/color.dart';
import 'package:flutter/material.dart';

const double horizontalPadding = 24;
const double verticalPadding = 12;

class AppButtonTheme {
  AppButtonTheme._();

  static final buttonTheme = ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    // layoutBehavior: ButtonBarLayoutBehavior.padded,
    // minWidth: 0,
    // height: 0,
    padding: const EdgeInsetsGeometry.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    ),
    // shape: ShapeBorder.lerp(a, b, t),
    // alignedDropdown: false,
    buttonColor: AppColors.primary,
    disabledColor: AppColors.disabled,
    focusColor: AppColors.focus,
    // hoverColor: ColorConstant.hover,
    // highlightColor: ColorConstant.highlight,
    // splashColor: ColorConstant.splash,
    // MaterialTapTargetSize? materialTapTargetSize,
  );
}
