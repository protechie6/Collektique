import 'package:flutter/material.dart';
import 'package:watch_vault/utils/all_constants.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.backgroundColor,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.backgroundColor),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.backgroundColor),
);