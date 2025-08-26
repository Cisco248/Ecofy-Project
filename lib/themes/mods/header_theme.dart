import 'package:e_wms_mobile/utilities/constants/color.dart';
import 'package:flutter/material.dart';

class AppHeaderTheme {
  AppHeaderTheme._();

  static final lightHeaderTheme = AppBarTheme(
    backgroundColor: AppColors.appBgLight,
    // foregroundColor: ColorConstant,
    elevation: 0,
    // scrolledUnderElevation: ,
    shadowColor: AppColors.shadowLight,
    // surfaceTintColor: AppColors.bgLight,
    // shape: ,
    // iconTheme: ,
    // actionsIconTheme: ,
    centerTitle: true,
    // titleSpacing: ,
    // leadingWidth: ,
    // toolbarHeight: ,
    // toolbarTextStyle: ,
    titleTextStyle: TextStyle(fontSize: 24),
    // systemOverlayStyle: ,
    // actionsPadding: ,
  );

  static final darkHeaderTheme = AppBarTheme(
    backgroundColor: AppColors.bgDark,
    // foregroundColor: ColorConstant,
    elevation: 0,
    // scrolledUnderElevation: ,
    shadowColor: AppColors.shadowDark,
    // surfaceTintColor: ColorConstant.darkBackground,
    // shape: ,
    // iconTheme: ,
    // actionsIconTheme: ,
    centerTitle: true,
    // titleSpacing: ,
    // leadingWidth: ,
    // toolbarHeight: ,
    // toolbarTextStyle: ,
    titleTextStyle: TextStyle(fontSize: 20),
    // systemOverlayStyle: ,
    // actionsPadding: ,
  );
}
