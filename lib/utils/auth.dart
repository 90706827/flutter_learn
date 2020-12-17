import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/common/router/routes_param.dart';
import 'package:flutter_learn/config/parameter.dart';
import 'package:flutter_learn/utils/storage_util.dart';

import '../global.dart';

class Auth {
  // 判断用户是否存在
  Future<bool> existToken() async {
    var userProfile = StorageUtil().getJson(Param.userLogin);
    return userProfile != null ? true : false;
  }

  //删除缓存
  Future deleteAuth() async {
    await StorageUtil().remove(Param.userLogin);
    Global.userLogin = null;
  }

  // 重新登陆
  Future jumpLoginPage(BuildContext context) async {
    await deleteAuth();
    ExtendedNavigator.of(context).pushAndRemoveUntil(
        RoutesParam.signInPageRoute, (Route<dynamic> route) => false);
  }
}
