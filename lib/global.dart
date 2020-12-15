import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

import 'entity/user_info.dart';

class Global {
  // 用户配置
  static UserInfo userLogin = UserInfo(accessToken: null);
  // android 设备信息
  static AndroidDeviceInfo androidDeviceInfo;
  // Iso 设备信息
  static IosDeviceInfo iosDeviceInfo;
  // 包信息
  static PackageInfo packageInfo;
  // 是否 ios
  static bool isIOS = Platform.isIOS;
  /// 是否第一次打开
  static bool firstOpen = false;


}
