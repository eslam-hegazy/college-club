import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:video2/bussiness_logic/search_cubit/search_cubit.dart';
import 'package:video2/presentation/style/colors.dart';
import 'package:video2/presentation/widgets/default_lottile_images.dart';
import 'package:video2/presentation/widgets/default_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  WebViewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final _key = UniqueKey();
  bool isLoading = true;
  int processNum = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: AppColor.kBlack,
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.kWhite,
          ),
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: widget.url,
              gestureNavigationEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
              onProgress: (process) {
                setState(() {
                  processNum = process;
                });
              },
              onPageStarted: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
            isLoading
                ? Center(
                    child:
                        defaultLottieImage(image: "loading.zip", height: 15.h),
                  )
                : Stack(),
          ],
        ),
      ),
    );
  }
}
