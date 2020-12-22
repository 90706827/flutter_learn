import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_learn/pages/index/index_page.dart';
import 'package:flutter_learn/pages/sign_in/sign_in_page.dart';
import 'package:flutter_learn/pages/sign_up/sign_up_page.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(
      page: IndexPage,
      initial: true,
    ),
    MaterialRoute(
      page: SignInPage,
      initial: true,
    ),
    MaterialRoute(
      page: SignUpPage,
      initial: true,
    ),
  ],
)
class $AppRouter {}
