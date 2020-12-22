import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'common/router/app_router.dart';
import 'common/router/auth_guard.dart';
import 'config/app_state.dart';
import 'global.dart';

Future<void> main() async {
  //系统初始化
  await Global.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(
          value: Global.appState,
        ),
      ],
      child: Consumer<AppState>(builder: (context, appState, _) {
        if (appState.getGray) {
          return ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
            child: NewsApp(),
          );
        } else {
          return NewsApp();
        }
      }),
    ),
  );
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "蝴蝶",
      debugShowCheckedModeBanner: true,
      builder: ExtendedNavigator<AppRouter>(
        initialRoute: Routes.indexPageRoute,
        router: AppRouter(),
        guards: [AuthGuard()],
      ),
    );
  }
}
