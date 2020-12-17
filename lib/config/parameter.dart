class Param {
  static const String deviceFirstOpen = "device_first_open";
  static const String userLogin = "user_login";

  //链接服务器地址
  static const String serverApiUrl = 'http://localhost:8080';

  // 链接服务器超时时间，单位毫秒
  static const int connectTimeout = 10000;

  // 响应流上前后两次接受到数据的间隔，单位为毫秒。
  static const int receiveTimeout = 5000;
}
