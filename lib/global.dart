import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/config/parameter.dart';
import 'package:flutter_learn/utils/storage_util.dart';
import 'package:package_info/package_info.dart';

import 'config/app_state.dart';
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
  static bool ios = Platform.isIOS;

  /// 是否第一次打开
  static bool firstOpen = false;

  // 状态
  static AppState appState = AppState();

  // 是否 release
  static bool get release => bool.fromEnvironment("dart.vm.product");

  // 持久化用户信息
  static Future<bool> saveProfile(UserInfo userInfo) {
    userLogin = userInfo;
    return StorageUtil().setJson(Param.userProfile, userInfo.toJson());
  }

  static Future init() async {
    //运行初始化
    WidgetsFlutterBinding.ensureInitialized();
    // 读取设备信息
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Global.ios) {
      Global.iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    } else {
      Global.androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    }
    // 包信息
    Global.packageInfo = await PackageInfo.fromPlatform();
    //本地缓存
    await StorageUtil.init();

    // 读取设备第一次打开
    firstOpen = !StorageUtil().getBool(Param.deviceFirstOpen);
    if (firstOpen) {
      StorageUtil().setBool(Param.deviceFirstOpen, true);
    }
    // 读取离线用户信息
    var profileInfo = StorageUtil().getJson(Param.userProfile);
    if (profileInfo != null) {
      userLogin = UserInfo.fromJson(profileInfo);
      firstOpen = true;
    }

    print("Android设备ID:[${androidDeviceInfo.androidId}]");
    print("是否release:[${Global.release}]");
    print("是否ISO:[${Global.ios}]");
    print(
        "包信息[${packageInfo.appName}]-[${packageInfo.packageName}]-[${packageInfo.version}]-[${packageInfo.buildNumber}]");
  }
}
