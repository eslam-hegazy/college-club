import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/presentation/screens/taps/search/web_view_screen.dart';
import 'package:video2/presentation/style/colors.dart';
import 'package:video2/presentation/widgets/default_lottile_images.dart';
import 'package:video2/presentation/widgets/default_text.dart';
import 'package:video2/presentation/widgets/item_setting.dart';

import '../../../bussiness_logic/global_cubit/global_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
        builder: (context, index) {
          var cubit = GlobalCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    SizedBox(height: 1.h),
                    cubit.getStatus() == true
                        ? defaultLottieImage(
                            image: "male_image.zip", height: 18.h)
                        : defaultLottieImage(
                            image: "female_image.zip", height: 18.h),
                    defaultText(
                      text: cubit.getUserName().toString().toUpperCase(),
                      size: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    defaultText(
                      text: cubit.getBio().toString().toLowerCase(),
                      size: 12,
                      color: AppColor.kGrey,
                    ),
                    SizedBox(height: 1.h),
                    Expanded(
                      child: Material(
                        elevation: 10,
                        color: AppColor.kBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.h),
                        child: Padding(
                          padding: EdgeInsets.all(3.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              itemSetting(
                                icon: Icons.language,
                                title: "language".tr(),
                                iconT: Icons.change_circle,
                                status: true,
                                press: () {
                                  changeLanguage(context);
                                },
                              ),
                              itemSetting(
                                icon: Icons.nightlight_outlined,
                                title: "theme".tr(),
                                status: true,
                                iconT: Icons.change_circle,
                                press: () {
                                  changeTheme(context);
                                },
                              ),
                              itemSetting(
                                icon: Icons.help_outline,
                                title: "about".tr(),
                                status: true,
                                iconT: Icons.call_missed_outgoing_outlined,
                                press: () {
                                  navigateTo(
                                      context,
                                      WebViewScreen(
                                          url:
                                              "https://www.linkedin.com/in/eslam-hegazy-08223a1b7/"));
                                },
                              ),
                              itemSetting(
                                icon: Icons.logout_outlined,
                                title: "logout".tr(),
                                press: () {
                                  cubit.logOut();
                                },
                                iconT: Icons.check_circle_outline_outlined,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, index) {});
  }
}
