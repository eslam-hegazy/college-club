import 'package:flutter/material.dart';
import 'package:video2/presentation/style/colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColor.kWhite,
  primaryColor: AppColor.kWhite,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.kBlack,
    elevation: 2,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    titleTextStyle: TextStyle(
      color: AppColor.kBlack,
    ),
    centerTitle: true,
    backgroundColor: AppColor.kWhite,
    actionsIconTheme: IconThemeData(
      color: AppColor.kBlack,
    ),
    iconTheme: IconThemeData(
      color: AppColor.kBlack,
    ),
  ),
);
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColor.kBlack,
  primaryColor: AppColor.kBlack,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.kWhite,
    elevation: 2,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: AppColor.kWhite,
    ),
    backgroundColor: AppColor.kBlack,
    actionsIconTheme: IconThemeData(
      color: AppColor.kWhite,
    ),
    iconTheme: IconThemeData(
      color: AppColor.kWhite,
    ),
  ),
);
