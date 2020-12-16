import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/config/parameter.dart';

// https://github.com/flutterchina/dio/blob/master/README-ZH.md
class HttpUtil {
  static HttpUtil instance = HttpUtil.internal();

  factory HttpUtil() => instance;

  Dio dio;
  CancelToken cancelToken = new CancelToken();
  // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
  HttpUtil.internal(){
    BaseOptions options = new BaseOptions(
      //请求地址
      baseUrl: Param.serverApiUrl,
      connectTimeout: Param.connectTimeout,
      receiveTimeout: Param.receiveTimeout,
      headers: {},
      // 请求的Content-Type，默认值是"application/json; charset=utf-8"
      contentType: Headers.jsonContentType,
      //[ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      //默认值是 `JSON`,
      //以二进制方式接受响应数据，使用 `STREAM`.
      //以文本(字符串)格式接收响应数据，使用 `PLAIN`.
      responseType: ResponseType.json,

    );
    dio = Dio(options);
  }

}