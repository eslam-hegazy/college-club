import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/bussiness_logic/global_cubit/global_cubit.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/presentation/screens/splash_screen.dart';
import 'package:video2/presentation/style/colors.dart';
import 'package:video2/presentation/widgets/default_svg_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(builder: (context, state) {
      var cubit = GlobalCubit.get(context);
      return Scaffold(
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: DotNavigationBar(
            dotIndicatorColor: AppColor.kWhite,
            enableFloatingNavBar: true,
            enablePaddingAnimation: true,
            unselectedItemColor: AppColor.kWhite,
            backgroundColor: AppColor.kBlue,
            selectedItemColor: AppColor.kRed,
            currentIndex: cubit.currentIndex,
            duration: const Duration(seconds: 1),
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: cubit.iconHome
                .map(
                  (e) => DotNavigationBarItem(
                    icon: Icon(e),
                    selectedColor: AppColor.kWhite.withOpacity(0.5),
                  ),
                )
                .toList(),
          ),
        ),
        body: cubit.screen[cubit.currentIndex],
      );
    }, listener: (context, state) {
      if (state is SignOutSuccess) {
        navigateWithReplace(context, SplashScreen());
      }
    });
  }
}
