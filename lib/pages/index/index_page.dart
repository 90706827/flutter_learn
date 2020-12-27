import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_learn/common/update/AppUpdateUtil.dart';
import 'package:flutter_learn/global.dart';
import 'package:flutter_learn/pages/sign_in/sign_in_page.dart';
import 'package:flutter_learn/pages/welcome/welcome_page.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:permission_handler/permission_handler.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
    if (Global.release == true) {
      doAppUpdate();
    }
  }

  Future doAppUpdate() async {
    await Future.delayed(Duration(seconds: 3), () async {
      if (Global.ios == false && await Permission.storage.isGranted == false) {
        await [Permission.storage].request();
      }
      if (await Permission.storage.isGranted) {
        AppUpdateUtil().run(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 734),
      allowFontScaling: true,
      child: Scaffold(
        body: Global.firstOpen == true
            ? WelcomePage()
            : Global.offLineLogin == true
                ? SignInPage()
                : SignInPage(),
      ),
    );
  }
}
