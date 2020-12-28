import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/common/router/app_router.dart';
import 'package:flutter_learn/config/app_colors.dart';
import 'package:flutter_learn/config/app_radii.dart';
import 'package:flutter_learn/utils/screen.dart';

class WelcomePage extends StatelessWidget {
  /// 页头标题
  Widget _buildPageHeadTitle() {
    return Container(
      margin: EdgeInsets.only(top: setHeight(60 + 44.0)),
      // 顶部系统栏 44px
      child: Text(
        "Features",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          fontSize: setFontSize(24),
          height: 1,
        ),
      ),
    );
  }

  /// 开始按钮
  Widget _buildStartButton(BuildContext context) {
    return Container(
      width: setWidth(295),
      height: setHeight(44),
      margin: EdgeInsets.only(bottom: setHeight(20)),
      child: FlatButton(
        color: AppColors.primaryElement,
        textColor: AppColors.primaryElementText,
        child: Text("开始"),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.k6pxRadius,
        ),
        onPressed: () {
          ExtendedNavigator.root.push(Routes.signInPageRoute);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "welcome",
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: setFontSize(16),
              ),
            ),
            _buildStartButton(context),
          ],
        ),
      ),
    );
  }
}
