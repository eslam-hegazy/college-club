import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sizer/sizer.dart';
import 'package:video2/bussiness_logic/global_cubit/global_cubit.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/presentation/style/colors.dart';
import 'package:video2/presentation/widgets/default_button.dart';
import 'package:video2/presentation/widgets/default_lottile_images.dart';
import 'package:video2/presentation/widgets/default_text.dart';
import 'package:video2/presentation/widgets/default_text_form_field.dart';
import 'package:video2/presentation/widgets/default_toast.dart';

class GenerateImage extends StatelessWidget {
  GenerateImage({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
        builder: (context, state) {
          var cubit = GlobalCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: defaultText(
                  text: "generate_image".tr(),
                  size: 14,
                  fontWeight: FontWeight.bold),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: defaultTextFormField(
                          controller: searchController,
                          hintText: "search_generate_image".tr(),
                          labelText: null,
                          icon: null,
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Material(
                        elevation: 6,
                        borderRadius: BorderRadius.circular(2.h),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              alignment: Alignment.center,
                              items: List.generate(
                                cubit.dropListValues.length,
                                (index) => DropdownMenuItem<String>(
                                  value: cubit.dropListSizes[index],
                                  child: defaultText(
                                      text: cubit.dropListSizes[index],
                                      size: 12),
                                ),
                              ),
                              hint: defaultText(
                                  text: cubit.currentDropList,
                                  size: 10,
                                  fontWeight: FontWeight.bold),
                              onChanged: (value) {
                                cubit.changeItemDropList(value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                    child: defaultButton("generate".tr(), () {
                      if (searchController.text.isNotEmpty) {
                        cubit.generateImage(
                            prompt: searchController.text,
                            n: 3,
                            size: "1024x1024");
                      } else {
                        defaultToast(
                            text: "error_search".tr(),
                            color: AppColor.kRed,
                            type: ToastGravity.BOTTOM);
                      }
                    }),
                  ),
                  stateImage(state, cubit.imageData),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
