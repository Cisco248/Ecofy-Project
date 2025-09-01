import 'package:e_wms_mobile/utilities/constants/color.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  static const TextStyle inputHint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.disabled,
  );

  static final textLightTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.txtLight,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.txtLight,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: AppColors.txtLight,
    ),
    headlineLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.txtLight,
    ),
    headlineMedium: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.txtLight,
    ),
    headlineSmall: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.txtLight,
    ),
    titleLarge: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.txtLight,
    ),
    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.txtLight,
    ),
    titleSmall: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.txtLight,
    ),
    bodyLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.txtLight,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.txtLight,
    ),
    bodySmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.txtLight,
    ),
    labelLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.txtLight,
    ),
    labelMedium: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.txtLight,
    ),
    labelSmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.txtLight,
    ),
  );

  static const textDarkTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.txtDark,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.txtDark,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColors.txtDark,
    ),
    headlineLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.txtDark,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.txtDark,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.txtDark,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.txtDark,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.txtDark,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.txtDark,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.txtDark,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.txtDark,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.txtDark,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.txtDark,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.txtDark,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.txtDark,
    ),
  );
}
