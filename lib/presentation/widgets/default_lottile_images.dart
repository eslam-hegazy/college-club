import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

Widget defaultLottieImage({image, height, Alignment? alignment}) {
  return Container(
    alignment: alignment ?? Alignment.center,
    child: Lottie.asset('assets/images/$image',
        height: height,
        alignment: Alignment.center,
        animate: true,
        repeat: true,
        reverse: true),
  );
}
