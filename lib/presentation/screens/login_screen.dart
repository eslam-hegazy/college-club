import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'package:sizer/sizer.dart';
import 'package:video2/bussiness_logic/search_cubit/search_cubit.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/data/local/cache_helper.dart';
import 'package:video2/presentation/style/colors.dart';
import 'package:video2/presentation/view/show_dialog.dart';
import 'package:video2/presentation/widgets/default_button.dart';
import 'package:video2/presentation/widgets/default_text.dart';
import 'package:video2/presentation/widgets/default_toast.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LocalAuthentication auth = LocalAuthentication();
  late bool canCheckBiometric;
  late List<BiometricType> availableBiometric;
  String autherized = "Not autherized";

  //////Check
  Future<void> checkBiometric() async {
    late bool canCheck;
    try {
      canCheck = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      canCheckBiometric = canCheck;
    });
  }

  //this function will get all the available biometrics inside our device
  //it will return a list of objects, but for our example it will only
  //return the fingerprint biometric
  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> available;
    try {
      available = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      availableBiometric = available;
    });
  }

  //this function will open an authentication dialog
  // and it will check if we are authenticated or not
  // so we will add the major action here like moving to another activity
  // or just display a text that will tell us that we are authenticated
  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger print to authenticate",
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      autherized =
          authenticated ? "Autherized success" : "Failed to authenticate";
      if (authenticated) {
        authenticate();
      } else {
        defaultToast(text: "Please scan your finger", color: AppColor.kRed);
        // toast("Please scan your finger", Colors.red);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    checkBiometric();
    getAvailableBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.fingerprint, size: 16.h),
              SizedBox(height: 5.h),
              defaultText(text: "login", size: 30, fontWeight: FontWeight.bold),
              SizedBox(
                height: 2.h,
              ),
              defaultText(
                  text: "titleLogin", size: 18, fontWeight: FontWeight.bold),
              defaultText(
                text: "subTitleLogin",
                size: 12,
                fontWeight: FontWeight.bold,
                color: AppColor.kGrey,
              ),
              SizedBox(
                height: 8.h,
              ),
              defaultButton(
                "authButton".tr(),
                () {
                  authenticate();
                },
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    var name = CacheHelper.getDataFromSharedPreference(key: "name");
    if (name != null) {
      navigateWithReplace(context, const HomeScreen());
      SearchCubit.get(context).getNewsData();
    } else {
      SearchCubit.get(context).getNewsData();

      showDialog(
          context: context,
          useSafeArea: false,
          barrierColor: Colors.white.withOpacity(0.3),
          builder: (context) {
            return ShowDialog();
          });
    }
  }
}
