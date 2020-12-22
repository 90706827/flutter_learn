import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_learn/global.dart';
import 'package:flutter_learn/pages/welcome/welcome_page.dart';
import 'package:flutter_screenutil/screenutil_init.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 734),
      allowFontScaling: true,
      child: Scaffold(
        body: Global.firstOpen == true ? WelcomePage() : WelcomePage(),
      ),
    );
  }
}
