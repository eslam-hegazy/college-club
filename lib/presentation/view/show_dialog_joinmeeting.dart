import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import 'package:video2/bussiness_logic/global_cubit/global_cubit.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/presentation/screens/home_screen.dart';
import 'package:video2/presentation/screens/taps/conference/live_screen.dart';
import 'package:video2/presentation/style/colors.dart';
import 'package:video2/presentation/widgets/default_button.dart';
import 'package:video2/presentation/widgets/default_lottile_images.dart';
import 'package:video2/presentation/widgets/default_text.dart';
import 'package:video2/presentation/widgets/default_text_form_field.dart';
import 'package:video2/presentation/widgets/default_toast.dart';

class ShowDialogJoinMeeting extends StatelessWidget {
  ShowDialogJoinMeeting({
    Key? key,
  }) : super(key: key);

  var linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);

        return AlertDialog(
          elevation: 10,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.h),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              cubit.getStatus() == true
                  ? defaultLottieImage(image: "male_image.zip", height: 12.h)
                  : defaultLottieImage(image: "female_image.zip", height: 12.h),
              defaultText(
                  text: "${"title".tr().toLowerCase()}, ${cubit.getUserName()}",
                  size: 14),
              defaultText(
                  text: "join_meeting_str".tr(),
                  size: 11,
                  color: AppColor.kGrey),
              SizedBox(height: 1.h),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(2.h),
                child: TextFormField(
                  controller: linkController,
                  decoration: InputDecoration(
                    hintText: "hint_join".tr(),
                    hintStyle: GoogleFonts.cairo(),
                    prefixIcon: const Icon(Icons.add_link_outlined),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: "e",
                    backgroundColor:
                        cubit.valMic == true ? null : AppColor.kRed,
                    onPressed: () {
                      cubit.changeMicrophone();
                    },
                    child: cubit.valMic == true
                        ? const Icon(
                            Icons.mic_none,
                          )
                        : Icon(
                            Icons.mic_off,
                            color: AppColor.kWhite,
                          ),
                  ),
                  FloatingActionButton(
                    heroTag: "t",
                    backgroundColor:
                        cubit.valVid == true ? null : AppColor.kRed,
                    onPressed: () {
                      cubit.changeVideo();
                    },
                    child: cubit.valVid == true
                        ? const Icon(Icons.videocam)
                        : Icon(
                            Icons.videocam_off,
                            color: AppColor.kWhite,
                          ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              defaultButton(
                "join_meeting".tr(),
                () {
                  if (linkController.text.isNotEmpty) {
                    navigateWithReplace(
                      context,
                      LiveStream(
                        userName: cubit.getUserName() ?? "Guest !",
                        conferenceID: linkController.text,
                        mic: cubit.valMic,
                        vid: cubit.valVid,
                      ),
                    );
                  } else {
                    defaultToast(
                      text: "toast_join".tr(),
                      color: AppColor.kRed,
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is LoginSuccess) {
          navigateWithReplace(context, HomeScreen());
        }
      },
    );
  }
}
