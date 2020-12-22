class AppParam {
  static const String deviceFirstOpen = "device_first_open";
  static const String userLogin = "user_login";

  // 链接服务器地址
  static const String serverApiUrl = 'http://localhost:8080';

  // 链接服务器超时时间，单位毫秒
  static const int connectTimeout = 10000;

  // 响应流上前后两次接受到数据的间隔，单位为毫秒。
  static const int receiveTimeout = 5000;

  // 是否启用代理
  static const bool proxyEnable = false;

  //代理服务IP
  static const String proxyIP = "127.0.0.1";

  // 代理服务端口
  static const String proxyPort = "8866";

  // 是否启用缓存
  static const bool cacheEnable = false;

  // 缓存的最长时间，单位秒
  static const int cacheMaxTime = 1000;

  // 最大缓存数
  static const int cacheCount = 100;
}
