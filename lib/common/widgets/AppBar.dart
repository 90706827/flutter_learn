import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//透明背景
Widget transparentAppBar({
  @required BuildContext context,
  Widget title,
  Widget leading,
  List<Widget> actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Title != null
        ? Center(
            child: title,
          )
        : null,
    leading: leading,
    actions: actions,
  );
}
