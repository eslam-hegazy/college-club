import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../style/colors.dart';
import 'default_text.dart';

Widget itemSetting({
  required IconData icon,
  required String title,
  required IconData iconT,
  bool? status,
  required VoidCallback press,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      InkWell(
        onTap: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 3.h,
              backgroundColor: AppColor.kWhite.withOpacity(0.2),
              child: Icon(icon),
            ),
            SizedBox(width: 4.w),
            defaultText(text: title, size: 14, fontWeight: FontWeight.w600),
            const Spacer(),
            Icon(iconT),
          ],
        ),
      ),
      status == true
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: Divider(
                color: AppColor.kWhite.withOpacity(0.4),
              ),
            )
          : Container(),
    ],
  );
}
