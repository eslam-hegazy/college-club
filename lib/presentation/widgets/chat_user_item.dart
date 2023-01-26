import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/bussiness_logic/global_cubit/global_cubit.dart';
import 'package:video2/data/model/response/response_message_model.dart';
import 'package:video2/presentation/widgets/default_toast.dart';

import '../style/colors.dart';
import 'default_lottile_images.dart';
import 'default_text.dart';

Widget ChatUserItem(ResponseMessageModel model, context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h),
    child: Directionality(
      textDirection:
          model.type == "user" ? TextDirection.rtl : TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: model.type == "user"
                ? GlobalCubit.get(context).getStatus() == true
                    ? defaultLottieImage(image: "male_image.zip", height: 20.h)
                    : defaultLottieImage(
                        image: "female_image.zip", height: 20.h)
                : const Icon(Icons.bolt),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Stack(
              children: [
                Material(
                  color: model.type == "user"
                      ? AppColor.kBlue.withOpacity(0.2)
                      : AppColor.kGrey,
                  elevation: 5,
                  borderRadius: BorderRadius.circular(2.h),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: InkWell(
                        onTap: () {
                          FlutterClipboard.copy(model.message).then((value) {
                            defaultToast(text: "copy".tr());
                          });
                        },
                        child: defaultText(
                          text: model.message.trim(),
                          size: 12,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
