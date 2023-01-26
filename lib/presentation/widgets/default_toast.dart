import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../style/colors.dart';

void defaultToast({required String text, Color? color, ToastGravity? type}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: type ?? ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: color ?? AppColor.kBlue,
      textColor: Colors.white,
      fontSize: 12.sp);
}
