import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../style/colors.dart';
import 'default_text.dart';

Widget defaultButton(String text, VoidCallback press) {
  return MaterialButton(
    minWidth: double.infinity,
    elevation: 6,
    height: 7.h,
    onPressed: press,
    color: AppColor.kBlue,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.sp),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    ),
    child: defaultText(
      text: text,
      size: 14,
      fontWeight: FontWeight.bold,
      color: AppColor.kWhite,
    ),
  );
}
