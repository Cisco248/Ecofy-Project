import 'package:flutter/material.dart';
import 'package:wms_app/core/constants/color.dart';

class AppCardTheme {
  AppCardTheme._();

  static final cardLightTheme = CardThemeData(
    color: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.black12,
    elevation: 4,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: AppColors.borderLight,
        width: 1.5,
        style: BorderStyle.solid,
      ),
    ),
    clipBehavior: Clip.hardEdge,
  );

  static final cardDarkTheme = CardThemeData(
    color: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.black45,
    elevation: 4,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: AppColors.borderDark,
        width: 1.5,
        style: BorderStyle.solid,
      ),
    ),
    clipBehavior: Clip.antiAlias,
  );
}
