import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

import 'package:video2/data/model/response/response_news_model.dart';

import '../style/colors.dart';
import '../widgets/default_shimmer_container.dart';
import '../widgets/default_text.dart';

class ItemSearchView extends StatelessWidget {
  const ItemSearchView({
    Key? key,
    required this.responseNewsModel,
    required this.press,
  }) : super(key: key);
  final ResponseNewsModel responseNewsModel;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 9,
              borderRadius: BorderRadius.circular(2.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.h),
                child: CachedNetworkImage(
                  height: 30.h,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  imageUrl: responseNewsModel.urlToImage.toString(),
                  placeholder: (context, url) => defaultShimmerContainer(25.h),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            defaultText(
              text: responseNewsModel.author ?? "",
              textAlign: TextAlign.start,
              maxLines: 2,
              size: 18,
            ),
            defaultText(
              text: responseNewsModel.title ?? "",
              textAlign: TextAlign.start,
              color: AppColor.kGrey,
              size: 13,
              maxLines: 3,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: defaultText(
                  text: responseNewsModel.data
                      .toString()
                      .split('T')[0]
                      .toString(),
                  size: 12,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.end),
            ),
          ],
        ),
      ),
    );
  }
}
