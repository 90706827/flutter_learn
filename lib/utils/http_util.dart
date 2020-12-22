import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_learn/config/app_param.dart';
import 'package:flutter_learn/exception/error_exception.dart';
import 'package:flutter_learn/global.dart';
import 'package:flutter_learn/utils/auth.dart';

import 'net_cache.dart';

// https://github.com/flutterchina/dio/blob/master/README-ZH.md
class HttpUtil {
  static HttpUtil instance = HttpUtil.internal();

  factory HttpUtil() => instance;

  Dio dio;
  CancelToken cancelToken = new CancelToken();

  // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
  HttpUtil.internal() {
    BaseOptions options = new BaseOptions(
      //请求地址
      baseUrl: AppParam.serverApiUrl,
      connectTimeout: AppParam.connectTimeout,
      receiveTimeout: AppParam.receiveTimeout,
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
    //Cookie管理
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    //添加拦截器
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        return options;
      },
      onResponse: (Response response) {
        return response;
      },
      onError: (DioError error) {
        ErrorException errorInfo = errorException(error);
        //TODO 错误提示
        print("Error Message:${errorInfo.message}");
        var context = error.request.extra["context"];
        if (context != null) {
          switch (errorInfo.code) {
            case 401:
              // 没有权限跳转登录页面
              Auth().jumpLoginPage(context);
              break;
            default:
          }
        }
        return error;
      },
    ));

    //增加缓存
    dio.interceptors.add(NetCache());
    // 在调试模式下需要抓包调试 所以我们使用代理，并禁用HTTPS证书校验
    if (!Global.release && AppParam.proxyEnable) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY ${AppParam.proxyIP}:${AppParam.proxyPort}";
        };
        //代理工具会提供一个抓包的签名证书，会通不过证书校验，所有我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  ErrorException errorException(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        {
          return ErrorException(code: -1, message: "请求取消！");
        }
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        {
          return ErrorException(code: -1, message: "连接超时");
        }
        break;
      case DioErrorType.SEND_TIMEOUT:
        {
          return ErrorException(code: -1, message: "请求超时");
        }
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        {
          return ErrorException(code: -1, message: "响应超时");
        }
        break;
      case DioErrorType.RESPONSE:
        {
          try {
            int errCode = error.response.statusCode;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                {
                  return ErrorException(code: errCode, message: "请求语法错误");
                }
                break;
              case 401:
                {
                  return ErrorException(code: errCode, message: "没有权限");
                }
                break;
              case 403:
                {
                  return ErrorException(code: errCode, message: "服务器拒绝执行");
                }
                break;
              case 404:
                {
                  return ErrorException(code: errCode, message: "无法连接服务器");
                }
                break;
              case 405:
                {
                  return ErrorException(code: errCode, message: "请求方法被禁止");
                }
                break;
              case 500:
                {
                  return ErrorException(code: errCode, message: "服务器内部错误");
                }
                break;
              case 502:
                {
                  return ErrorException(code: errCode, message: "无效的请求");
                }
                break;
              case 503:
                {
                  return ErrorException(code: errCode, message: "服务器挂了");
                }
                break;
              case 505:
                {
                  return ErrorException(code: errCode, message: "不支持HTTP协议请求");
                }
                break;
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  return ErrorException(
                      code: errCode, message: error.response.statusMessage);
                }
            }
          } on Exception catch (_) {
            return ErrorException(code: -1, message: "未知错误");
          }
        }
        break;
      default:
        {
          return ErrorException(code: -1, message: error.message);
        }
    }
  }
}
