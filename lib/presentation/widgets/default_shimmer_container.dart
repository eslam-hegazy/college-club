import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../style/colors.dart';

Widget defaultShimmerContainer(double? height) {
  return Padding(
    padding: EdgeInsets.all(2.h),
    child: Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        height: height?.h ?? 20.h,
        color: AppColor.kGrey.withOpacity(0.2),
      ),
    ),
  );
}
