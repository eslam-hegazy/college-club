import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import 'package:video2/bussiness_logic/search_cubit/search_cubit.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/presentation/screens/taps/search/web_view_screen.dart';
import 'package:video2/presentation/style/colors.dart';
import 'package:video2/presentation/view/item_search_view.dart';
import 'package:video2/presentation/widgets/default_lottile_images.dart';
import 'package:video2/presentation/widgets/default_text.dart';

import '../../../widgets/default_shimmer_container.dart';

class SearchEngineScreen extends StatelessWidget {
  SearchEngineScreen({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: defaultText(
                  text: "search_engine".tr(),
                  size: 14,
                  fontWeight: FontWeight.bold),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(3.h),
                      child: TextFormField(
                        controller: controller,
                        autofocus: true,
                        onChanged: (value) {
                          cubit.search(value);
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: "search".tr(),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  if (state is LoadingSearchBarState)
                    const LinearProgressIndicator(),
                  cubit.searchData.isNotEmpty
                      ? ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                navigateTo(
                                    context,
                                    WebViewScreen(
                                        url: cubit.searchData[index].link
                                            .toString()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(cubit
                                          .searchData[index].thumbnailUrl
                                          .toString()),
                                      backgroundColor:
                                          AppColor.kGrey.withOpacity(0.2),
                                    ),
                                    title: defaultText(
                                        text: cubit.searchData[index].source
                                            .toString(),
                                        size: 12,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.start),
                                    subtitle: defaultText(
                                        text: cubit.searchData[index].domain
                                            .toString(),
                                        size: 10,
                                        textAlign: TextAlign.start),
                                  ),
                                  Material(
                                    elevation: 9,
                                    borderRadius: BorderRadius.circular(2.h),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2.h),
                                      child: CachedNetworkImage(
                                        height: 25.h,
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        imageUrl: cubit
                                            .searchData[index].imageUrl
                                            .toString(),
                                        placeholder: (context, url) =>
                                            defaultShimmerContainer(25.h),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  defaultText(
                                    text: cubit.searchData[index].title
                                        .toString(),
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    size: 15,
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: cubit.searchData.length,
                        )
                      : Column(
                          children: [
                            SizedBox(height: 20.h),
                            defaultLottieImage(
                                image: "generate_image.zip",
                                height: 35.h,
                                alignment: Alignment.center),
                          ],
                        ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
