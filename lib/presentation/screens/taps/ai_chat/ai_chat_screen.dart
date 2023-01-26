import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/presentation/screens/taps/ai_chat/chat_gpt_screen.dart';
import 'package:video2/presentation/screens/taps/ai_chat/generate_image.dart';
import 'package:video2/presentation/style/colors.dart';
import 'package:video2/presentation/widgets/default_button.dart';
import 'package:video2/presentation/widgets/default_lottile_images.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              defaultLottieImage(image: "bot_ai.json", height: 35.h),
              defaultButton(
                "generate_image".tr(),
                () {
                  navigateTo(
                    context,
                    GenerateImage(),
                  );
                },
              ),
              SizedBox(height: 2.h),
              defaultButton(
                "title_chat".tr(),
                () {
                  navigateTo(
                    context,
                    ChatGptScreen(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
