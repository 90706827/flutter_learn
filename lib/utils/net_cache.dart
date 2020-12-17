import 'dart:collection';

import 'package:dio/dio.dart';

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
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  Future onRequest(RequestOptions options) {
    // TODO: implement onRequest
    return super.onRequest(options);
  }
  @override
  Future onError(DioError err) {
    // TODO: implement onError
    return super.onError(err);
  }

  @override
  Future onResponse(Response response) {
    // TODO: implement onResponse
    return super.onResponse(response);
  }
}
