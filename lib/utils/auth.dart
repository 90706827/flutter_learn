import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/common/router/app_router.dart';
import 'package:flutter_learn/config/app_param.dart';
import 'package:flutter_learn/utils/storage_util.dart';
import 'package:flutter_learn/global.dart';

class Auth {
  // 判断用户是否存在
  Future<bool> existToken() async {
    var userProfile = StorageUtil().getJson(AppParam.userLogin);
    return userProfile != null ? true : false;
  }

  //删除缓存
  Future deleteAuth() async {
    await StorageUtil().remove(AppParam.userLogin);
    Global.userLogin = null;
  }

  // 重新登陆
  Future jumpLoginPage(BuildContext context) async {
    await deleteAuth();
    ExtendedNavigator.of(context).pushAndRemoveUntil(
        Routes.signInPageRoute, (Route<dynamic> route) => false);
  }
}
