import 'package:auto_route/auto_route.dart';
import 'package:flutter_learn/common/router/app_router.dart';
import 'package:flutter_learn/utils/auth.dart';

class AuthGuard extends RouteGuard {
  @override
  Future<bool> canNavigate(
    ExtendedNavigatorState<RouterBase> navigator,
    String routeName,
    Object arguments,
  ) async {
    var isAuth = await Auth().existToken();
    if (isAuth == false) {
      ExtendedNavigator.root.push(Routes.signInPageRoute);
    }
    return isAuth;
  }
}
