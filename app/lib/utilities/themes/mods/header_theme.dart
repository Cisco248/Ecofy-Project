import 'package:e_wms_mobile/utilities/constants/color.dart';
import 'package:flutter/material.dart';

class AppHeaderTheme {
  AppHeaderTheme._();

  static final lightHeaderTheme = AppBarTheme(
    backgroundColor: AppColors.primary,
    titleTextStyle: TextStyle(fontSize: 24),
    elevation: 10,
    shadowColor: AppColors.shadowLight,
    centerTitle: true,
    // foregroundColor: ColorConstant,
    // scrolledUnderElevation: ,
    // surfaceTintColor: AppColors.bgLight,
    // shape: ,
    // iconTheme: ,
    // actionsIconTheme: ,
    // titleSpacing: ,
    // leadingWidth: ,
    // toolbarHeight: ,
    // toolbarTextStyle: ,
    // systemOverlayStyle: ,
    // actionsPadding: ,
  );

  static final darkHeaderTheme = AppBarTheme(
    backgroundColor: AppColors.primary,
    elevation: 10,
    shadowColor: AppColors.shadowDark,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 20),
    // foregroundColor: ColorConstant,
    // scrolledUnderElevation: ,
    // surfaceTintColor: ColorConstant.darkBackground,
    // shape: ,
    // iconTheme: ,
    // actionsIconTheme: ,
    // titleSpacing: ,
    // leadingWidth: ,
    // toolbarHeight: ,
    // toolbarTextStyle: ,
    // systemOverlayStyle: ,
    // actionsPadding: ,
  );
}
