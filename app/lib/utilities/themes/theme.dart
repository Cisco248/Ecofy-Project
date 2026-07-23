import 'package:flutter/material.dart';
import 'package:wms_app/core/constants/color.dart';
import 'package:wms_app/core/constants/font.dart';
import 'mods/button_theme.dart';
import 'mods/input_theme.dart';
import 'mods/card_theme.dart';
import 'mods/header_theme.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.bgLight,
  appBarTheme: AppHeaderTheme.lightHeaderTheme,
  cardTheme: AppCardTheme.cardLightTheme,
  textTheme: AppTextStyles.textLightTheme,
  inputDecorationTheme: AppInputTheme.inputAppLightTheme,
  buttonTheme: AppButtonTheme.buttonTheme,
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Colors.transparent,
    backgroundColor: AppColors.gray,
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.bgDark,
  appBarTheme: AppHeaderTheme.darkHeaderTheme,
  cardTheme: AppCardTheme.cardDarkTheme,
  textTheme: AppTextStyles.textDarkTheme,
  inputDecorationTheme: AppInputTheme.inputAppDarkTheme,
  buttonTheme: AppButtonTheme.buttonTheme,
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Colors.transparent,
    backgroundColor: AppColors.cardDark,
  ),
);
