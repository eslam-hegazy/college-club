import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/bussiness_logic/global_cubit/global_cubit.dart';
import 'package:video2/bussiness_logic/search_cubit/search_cubit.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/presentation/screens/taps/search/search_engine_screen.dart';
import 'package:video2/presentation/screens/taps/search/web_view_screen.dart';
import 'package:video2/presentation/style/colors.dart';
import 'package:video2/presentation/view/item_search_view.dart';
import 'package:video2/presentation/widgets/default_shimmer_container.dart';
import 'package:video2/presentation/widgets/default_text.dart';

import '../../../widgets/default_lottile_images.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..getNewsData(),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => SearchCubit.get(context).getNewsData(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 6.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                  alignment: Alignment.centerLeft,
                  child: GlobalCubit.get(context).getStatus() == true
                      ? defaultLottieImage(
                          image: "male_image.zip",
                          height: 5.h,
                          alignment: Alignment.centerLeft)
                      : defaultLottieImage(
                          image: "female_image.zip",
                          height: 5.h,
                          alignment: Alignment.centerLeft),
                ),
                Text(
                  "app_name".tr(),
                  style: GoogleFonts.elMessiri(
                      fontSize: 22.sp, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 2.h),
                InkWell(
                  onTap: () {
                    navigateTo(context, SearchEngineScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Material(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(4.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        alignment: Alignment.center,
                        height: 7.h,
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Icon(Icons.search),
                            SizedBox(width: 3.w),
                            defaultText(text: "search".tr(), size: 14),
                            const Spacer(),
                            const Icon(Icons.settings_voice_outlined),
                            SizedBox(width: 3.w),
                            const Icon(Icons.camera_alt_outlined),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                BlocConsumer<SearchCubit, SearchState>(
                  builder: (context, state) {
                    var cubit = SearchCubit.get(context);
                    return state is LoadingSearchState
                        ? Column(
                            children: [
                              SizedBox(height: 22.h),
                              Center(
                                child: defaultLottieImage(
                                    image: "loading.zip",
                                    height: 15.h,
                                    alignment: Alignment.center),
                              ),
                            ],
                          )
                        : state is SuccessSearchState
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => Divider(
                                  color: AppColor.kGrey.withOpacity(0.5),
                                ),
                                itemBuilder: (context, index) {
                                  return ItemSearchView(
                                    responseNewsModel: cubit.newsData[index],
                                    press: () {
                                      navigateTo(
                                          context,
                                          WebViewScreen(
                                              url: cubit.newsData[index].url
                                                  .toString()));
                                    },
                                  );
                                },
                                itemCount: cubit.newsData.length,
                              )
                            : defaultLottieImage(
                                image: "no_internet.zip", height: 25.h);
                  },
                  listener: (context, state) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
