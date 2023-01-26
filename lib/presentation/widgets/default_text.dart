import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/presentation/style/colors.dart';

Widget defaultText({
  required String text,
  required double size,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
  int? maxLines,
}) {
  return Text(
    text.tr(),
    textAlign: textAlign ?? TextAlign.center,
    maxLines: maxLines ?? 50,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.cairo(
        fontSize: size.sp, fontWeight: fontWeight, color: color),
  );
}
