import 'package:dio/dio.dart';
import 'dart:developer' as developer;

const Map<String, dynamic> headers = {
  "Accept": "application/json",
};

const Map<String, dynamic> headersJson = {
  "Accept": "application/json",
  "Content-Type": "application/json; charset=UTF-8",
};

class Http {
  static const int connectTimeout = 8000;
  static const int receiveTimeout = 3000;
  static const String baseUrl = "https://4kdyw.qsclub.cn/";

  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(milliseconds: connectTimeout),
    responseType: ResponseType.json,
    receiveTimeout: const Duration(milliseconds: receiveTimeout),
  ));

  Future<String> getString(url, {options, cancelToken, data}) async {
    developer.log("$url,body:$data", name: 'get');

    late Response response;

    try {
      response = await _dio.get(url, cancelToken: cancelToken);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        developer.log("$e.message", name: 'get请求取消');
      } else {
        developer.log("$e", name: 'get请求发生错误');
      }
    }
    return response.data.toString();
  }
}

var httpApi = Http();
