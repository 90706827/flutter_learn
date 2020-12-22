import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_learn/config/app_param.dart';
import 'package:flutter_learn/utils/storage_util.dart';

class CacheObject {
  int timestamp;

  Response response;

  CacheObject(this.response)
      : timestamp = DateTime.now().millisecondsSinceEpoch;

  // @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  //为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  Future onRequest(RequestOptions options) async {
    if (!AppParam.cacheEnable) {
      return options;
    }
    // refresh 标记是否是"下拉刷新"
    bool refresh = options.extra["refresh"] == true;
    bool cacheDisk = options.extra["cacheDisk"] == true;
    // 如果是下拉刷新，先删除相关缓存
    if (refresh) {
      if (options.extra["list"] == true) {
        //若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
        cache.removeWhere((key, value) => key.contains(options.path));
      } else {
        // 如果不是列表，则只删除uri相同的缓存
        cache.remove(options.uri.toString());
      }
      //删除磁盘缓存
      if (cacheDisk) {
        await StorageUtil().remove(options.uri.toString());
      }
      return options;
    }
    //get 请求 开启缓存
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      //策略 内存缓存有限 然后才是磁盘缓存
      //内存缓存
      var ob = cache[key];
      if (ob != null) {
        //若缓存没有过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timestamp) / 1000 <
            AppParam.cacheMaxTime) {
          return cache[key].response;
        } else {
          cache.remove(key);
        }
      }
      //磁盘缓存
      if (cacheDisk) {
        var cacheData = StorageUtil().getJson(key);
        if (cacheData != null) {
          return Response(statusCode: 200, data: cacheData);
        }
      }
    }
  }

  @override
  Future onError(DioError err) async {
    //错误状态不缓存
  }

  @override
  Future onResponse(Response response) {
    //若果启用缓存，将返回结果保存到缓存
    RequestOptions options = response.request;
    //只缓存get的请求
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      //内存、磁盘都写缓存
      //缓存key
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      //磁盘缓存
      if (options.extra["cacheDisk"] == true) {
        StorageUtil().setJson(key, response.data);
      }
      //内存缓存
      if (cache.length >= AppParam.cacheCount) {
        //如果缓存数量超过最大数量限制，则先移除最早的一条记录
        cache.remove(cache[cache.keys.first]);
      }
      cache[key] = CacheObject(response);
    }
  }
}
