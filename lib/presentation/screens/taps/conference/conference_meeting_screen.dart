import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/bussiness_logic/global_cubit/global_cubit.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/presentation/style/colors.dart';
import 'package:video2/presentation/view/show_dialog_joinmeeting.dart';
import 'package:video2/presentation/view/show_dialog_newmeeting.dart';
import 'package:video2/presentation/widgets/default_lottile_images.dart';
import 'package:video2/presentation/widgets/default_meeting_button.dart';
import 'package:video2/presentation/widgets/default_text.dart';

class ConferenceMeetingScreen extends StatelessWidget {
  const ConferenceMeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              defaultLottieImage(image: "meeting.json", height: 23.h),
              SizedBox(height: 7.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  defaultMeetingButton(
                      icon: Icons.videocam,
                      title: "new_meeting".tr(),
                      press: () {
                        print(randomString());
                        showDialog(
                          context: context,
                          barrierColor: AppColor.kBlack.withOpacity(0.3),
                          builder: (context) {
                            return ShowDialogNewMeeting(
                                uuid: randomString().split('-')[0]);
                          },
                        );
                      },
                      color: AppColor.kRed),
                  SizedBox(
                    height: 10.h,
                    width: 10.h,
                    child: Column(
                      children: [
                        Divider(
                          endIndent: 5.h,
                        ),
                        defaultText(
                            text: "or".tr(),
                            size: 12,
                            fontWeight: FontWeight.w500),
                        const Divider(),
                      ],
                    ),
                  ),
                  defaultMeetingButton(
                    icon: Icons.add_box,
                    title: "join".tr(),
                    press: () {
                      showDialog(
                        context: context,
                        barrierColor: AppColor.kBlack.withOpacity(0.3),
                        builder: (context) {
                          return ShowDialogJoinMeeting();
                        },
                      );
                    },
                    color: AppColor.kBlue.withOpacity(0.7),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(2.h),
                child: ListTile(
                  title: defaultText(
                      text:
                          "${"title".tr()} ${cubit.getUserName().toString().toUpperCase()} !",
                      size: 12,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.start),
                  subtitle: defaultText(
                      text: "subTitle_conference".tr(),
                      size: 12,
                      textAlign: TextAlign.start),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
