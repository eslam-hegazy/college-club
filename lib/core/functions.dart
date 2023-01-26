import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
import 'package:video2/bussiness_logic/global_cubit/global_cubit.dart';
import 'package:video2/presentation/widgets/default_shimmer_container.dart';
import 'package:video2/presentation/widgets/default_toast.dart';

import '../data/model/response/response_image_model.dart';
import '../presentation/style/colors.dart';
import '../presentation/widgets/default_lottile_images.dart';

void changeLanguage(context) {
  translator.setNewLanguage(
    context,
    newLanguage: translator.currentLanguage == 'ar' ? 'en' : 'ar',
    remember: true,
    restart: true,
  );
}

/////////////get current language for news
String getCurrentLanguageForNews() {
  var lang = translator.currentLanguage;
  if (lang == 'ar') {
    return "eg";
  } else {
    return "us";
  }
}

/////////////get current language for news
String getCurrentLanguageForSearch() {
  var lang = translator.currentLanguage;
  return lang;
}

////////////change Theme
Future<void> changeTheme(context) async {
  bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;
  if (isDarkModeOn) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColor.kWhite,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return AdaptiveTheme.of(context).setLight();
  } else {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColor.kBlack,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return AdaptiveTheme.of(context).setDark();
  }
}

void statusBarColor() async {
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: savedThemeMode == AdaptiveThemeMode.light
          ? AppColor.kWhite
          : AppColor.kBlack,
      statusBarIconBrightness: savedThemeMode == AdaptiveThemeMode.light
          ? Brightness.dark
          : Brightness.light,
    ),
  );
}

void navigateWithReplace(context, widget) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          alignment: Alignment.center,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    ),
  );
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          alignment: Alignment.center,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    ),
  );
}

Widget stateImage(GlobalState state, List<ResponseImageModel> image) {
  if (state is LoadingGenerateImageState) {
    return Expanded(
      child: Center(
        child: defaultLottieImage(image: "loading.zip", height: 18.h),
      ),
    );
  } else if (state is SuccessGenerateImageState) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: image.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(5.h),
                  elevation: 5,
                  child: CachedNetworkImage(
                    height: 40.h,
                    imageUrl: image[index].image,
                    fit: BoxFit.fill,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.h),
                        image: DecorationImage(
                          image: imageProvider,
                          colorFilter: ColorFilter.mode(
                              AppColor.kBlack, BlendMode.lighten),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            defaultShimmerContainer(35.h),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FlutterClipboard.copy(image[index].image).then(
                      (value) => defaultToast(
                          text: "Copy Link Successfully",
                          type: ToastGravity.BOTTOM),
                    );
                  },
                  icon: Icon(
                    Icons.copy,
                    color: AppColor.kWhite,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  } else if (state is ErrorGenerateImageState) {
    return Expanded(
      child: Center(
        child: defaultLottieImage(image: "no_internet.zip", height: 40.h),
      ),
    );
  } else {
    return Expanded(
      child: defaultLottieImage(image: "generate_image.zip", height: 35.h),
    );
  }
}

////////////random link
String randomString() {
  var uuid = Uuid();
  return uuid.v1();
}
