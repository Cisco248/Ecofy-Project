import 'package:e_wms_mobile/utilities/constants/color.dart';
import 'package:flutter/material.dart';

class AppCardTheme {
  AppCardTheme._();

  static final cardLightTheme = CardThemeData(
    color: AppColors.bgLight,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.black12,
    elevation: 4,
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    clipBehavior: Clip.antiAlias,
  );

  static final cardDarkTheme = CardThemeData(
    color: AppColors.bgDark,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.black45,
    elevation: 4,
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    clipBehavior: Clip.antiAlias,
  );
}
