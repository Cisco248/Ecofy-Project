import 'package:flutter/material.dart';
import 'package:wms_app/core/constants/color.dart';
import 'package:wms_app/core/constants/font.dart';

class AppInputTheme {
  const AppInputTheme._();

  static final inputAppLightTheme = InputDecorationTheme(
    labelStyle: AppTextStyles.textLightTheme.labelLarge,
    filled: false,
    fillColor: AppColors.bgLight,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.borderLight, width: 2),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.borderLight, width: 2),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.borderLightFocus, width: 2),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.borderLightError, width: 2),
    ),
  );

  static final inputAppDarkTheme = InputDecorationTheme(
    filled: false,
    fillColor: AppColors.bgDark,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.borderDark, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.borderDark, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.borderDarkFocus, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.borderDarkError, width: 2),
    ),
  );
}
