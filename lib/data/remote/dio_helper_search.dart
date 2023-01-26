import 'package:dio/dio.dart';
import 'package:video2/constants.dart';
import 'package:video2/core/strings.dart';

class DioHelperSearch {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://google.serper.dev/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio!.get(
      url,
      queryParameters: query,
      options: Options(
        headers: {},
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> body,
  }) async {
    dio!.options.headers = query;
    return await dio!.post(
      url,
      data: body,
    );
  }
}
