import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/presentation/widgets/default_text.dart';

import '../style/colors.dart';

Widget defaultMeetingButton({
  required IconData icon,
  required String title,
  required VoidCallback press,
  required Color color,
}) {
  return Column(
    children: [
      MaterialButton(
        color: color,
        height: 8.h,
        elevation: 5,
        minWidth: 8.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.h),
        ),
        onPressed: press,
        child: Icon(
          icon,
          color: AppColor.kWhite,
          size: 4.h,
        ),
      ),
      SizedBox(height: 1.h),
      defaultText(text: title, size: 12, fontWeight: FontWeight.w700),
    ],
  );
}
