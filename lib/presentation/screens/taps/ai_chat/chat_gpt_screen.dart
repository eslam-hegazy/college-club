import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/bussiness_logic/global_cubit/global_cubit.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/data/model/response/response_message_model.dart';
import 'package:video2/presentation/style/colors.dart';
import 'package:video2/presentation/widgets/chat_user_item.dart';
import 'package:video2/presentation/widgets/default_lottile_images.dart';
import 'package:video2/presentation/widgets/default_text.dart';
import 'package:video2/presentation/widgets/default_text_form_field.dart';
import 'package:video2/presentation/widgets/default_toast.dart';

class ChatGptScreen extends StatelessWidget {
  ChatGptScreen({Key? key}) : super(key: key);
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);

        void onSend(String message) {
          if (message.isNotEmpty) {
            if (cubit.messagesData.length >= 3) {
              scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(microseconds: 1000),
                  curve: Curves.easeInOut);
            }
            cubit.messagesData
                .add(ResponseMessageModel(message: message, type: "user"));
            cubit.generateMessage(message);
            messageController.text = "";
          } else {
            defaultToast(text: "error_search".tr(), color: AppColor.kRed);
          }
        }

        return Scaffold(
            appBar: AppBar(
              title: defaultText(
                  text: "title_chat".tr(),
                  size: 14,
                  fontWeight: FontWeight.bold),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        cubit.messagesData.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(1.h),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: cubit.messagesData.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == cubit.messagesData.length) {
                                      return Container(
                                        height: 20.h,
                                      );
                                    } else {
                                      return ChatUserItem(
                                          cubit.messagesData[index], context);
                                    }
                                  },
                                ),
                              )
                            : Expanded(
                                child: Center(
                                    child: defaultLottieImage(
                                        image: "bot_ai.json", height: 40.h)),
                              ),
                        if (state is LoadingGenerateMessageState)
                          LinearProgressIndicator(
                            color: AppColor.kBlue,
                          ),
                        if (state is ErrorGenerateMessageState)
                          defaultText(
                              text: "Check Internet Connection", size: 12),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: defaultTextFormField(
                            controller: messageController,
                            hintText: "chat_gpt_text".tr(),
                            labelText: null,
                            textInputAction: TextInputAction.done,
                            icon: null,
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20.h),
                          child: IconButton(
                            onPressed: () {
                              onSend(messageController.text);
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
      listener: (context, state) {
        if (state is SuccessGenerateMessageState &&
            GlobalCubit.get(context).messagesData.length >= 4) {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(microseconds: 1000),
              curve: Curves.easeInOut);
        }
      },
    );
  }
}
