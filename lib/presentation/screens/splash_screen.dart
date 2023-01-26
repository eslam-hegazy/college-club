import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/presentation/screens/login_screen.dart';
import 'package:video2/presentation/widgets/default_lottile_images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 8), () {
      navigateWithReplace(context, const LoginScreen());
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 7.h),
          defaultLottieImage(image: "splash_image.zip", height: 30.h),
          SizedBox(height: 4.h),
          Text(
            "app_name".tr(),
            style: GoogleFonts.elMessiri(
                fontSize: 22.sp, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 18.h),
          defaultLottieImage(image: "loading.zip", height: 15.h),
        ],
      ),
    );
  }
}
