import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_state.dart';
import 'global.dart';

Future<void> main() async {
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
      home: Scaffold(
        appBar: AppBar(
          title: Text("AppMain"),
        ),
        body: Text("AppMain"),
      ),
    );
  }
}
