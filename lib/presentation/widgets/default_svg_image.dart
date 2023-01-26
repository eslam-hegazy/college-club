import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/presentation/style/colors.dart';

Widget defaultSvgImage(image, heightImage) {
  return SvgPicture.asset(
    "assets/images/$image",
    height: heightImage,
    color: AppColor.kWhite,
    alignment: Alignment.center,
  );
}
