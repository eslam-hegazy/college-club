import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/bussiness_logic/global_cubit/global_cubit.dart';
import 'package:video2/bussiness_logic/search_cubit/search_cubit.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/presentation/screens/home_screen.dart';
import 'package:video2/presentation/style/colors.dart';
import 'package:video2/presentation/widgets/default_button.dart';
import 'package:video2/presentation/widgets/default_lottile_images.dart';
import 'package:video2/presentation/widgets/default_text.dart';
import 'package:video2/presentation/widgets/default_text_form_field.dart';
import 'package:video2/presentation/widgets/default_toast.dart';

class ShowDialog extends StatelessWidget {
  ShowDialog({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);
        return AlertDialog(
          elevation: 10,
          title: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                cubit.currentSwitchMale == false
                    ? defaultLottieImage(
                        image: "female_image.zip", height: 10.h)
                    : defaultLottieImage(image: "male_image.zip", height: 10.h),
                SizedBox(height: 1.h),
                defaultText(
                    text: "personal_info".tr(),
                    size: 14,
                    fontWeight: FontWeight.bold),
                const Divider(),
              ],
            ),
          ),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.h),
              topRight: Radius.circular(5.h),
              bottomLeft: Radius.circular(3.h),
              bottomRight: Radius.circular(6.h),
            ),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  defaultTextFormField(
                    controller: nameController,
                    hintText: "hint_name".tr(),
                    labelText: "label_name".tr(),
                    icon: const Icon(Icons.person_outline_outlined),
                  ),
                  defaultTextFormField(
                    controller: bioController,
                    hintText: "hint_bio".tr(),
                    labelText: "label_bio".tr(),
                    icon: const Icon(Icons.biotech_outlined),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      defaultLottieImage(
                          image: "female_image.zip", height: 5.h),
                      Switch(
                        // thumb color (round icon)
                        activeColor: AppColor.kRed,
                        activeTrackColor: AppColor.kGrey,
                        inactiveThumbColor: Colors.blueGrey.shade600,
                        inactiveTrackColor: AppColor.kBlue,
                        splashRadius: 10.h,

                        // boolean variable value
                        value: cubit.currentSwitchMale,
                        // changes the state of the switch
                        onChanged: (value) {
                          cubit.changeSwitchMale(value);
                        },
                      ),
                      defaultLottieImage(image: "male_image.zip", height: 5.h),
                    ],
                  ),
                  defaultButton(
                    "login_button".tr(),
                    () {
                      if (nameController.text.isNotEmpty &&
                          bioController.text.isNotEmpty) {
                        cubit.login(
                          name: nameController.text,
                          bio: bioController.text,
                          status: cubit.currentSwitchMale,
                        );
                        defaultToast(text: "message_login".tr());
                      } else {
                        defaultToast(
                            text: "error_login".tr(), color: AppColor.kRed);
                      }
                    },
                  ),
                ],
              ),
            ),
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
