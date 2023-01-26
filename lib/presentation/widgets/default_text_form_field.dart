import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required String hintText,
  String? labelText,
  Icon? icon,
  EdgeInsets? padding,
  TextInputAction? textInputAction,
  ValueChanged<String>? onFieldSubmitted,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(2.h),
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: padding,
          labelStyle: GoogleFonts.cairo(),
          hintStyle: GoogleFonts.cairo(),
          labelText: labelText,
          prefixIcon: icon,
          border: InputBorder.none,
        ),
      ),
    ),
  );
}
