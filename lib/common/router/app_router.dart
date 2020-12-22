import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/pages/index/index_page.dart';
import 'package:flutter_learn/pages/sign_in/sign_in_page.dart';
import 'package:flutter_learn/pages/sign_up/sign_up_page.dart';

abstract class Routes {
  static const indexPageRoute = '/';
  static const signUpPageRoute = '/sign-up-page-route';
  static const signInPageRoute = '/sign-in-page-route';
  static const all = {
    indexPageRoute,
    signUpPageRoute,
    signInPageRoute,
  };
}

class AppRouter extends RouterBase {
  final _routes = <RouteDef>[
    RouteDef(Routes.indexPageRoute, page: IndexPage),
    RouteDef(Routes.signInPageRoute, page: SignInPage),
    RouteDef(Routes.signUpPageRoute, page: SignUpPage),
  ];

  final _pagesMap = <Type, AutoRouteFactory>{
    IndexPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => IndexPage(),
        settings: data,
      );
    },
    SignInPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignInPage(),
        settings: data,
      );
    },
    SignUpPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpPage(),
        settings: data,
      );
    },
  };

  @override
  Map get pagesMap => _pagesMap;

  @override
  List<RouteDef> get routes => _routes;
}
