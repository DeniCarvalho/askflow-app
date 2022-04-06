library auth_module;

import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/presentation.dart';

///
/// Auth module definition
///
class AuthModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      AuthRoutes.login,
      child: (_, __) => const LoginPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      AuthRoutes.forgot,
      child: (_, args) => const ForgotPassword(),
      transition: TransitionType.rightToLeft,
    ),
    ChildRoute(
      AuthRoutes.reset,
      child: (_, args) => ResetPassword(
        token: args.params['token'],
      ),
      transition: TransitionType.fadeIn,
    ),
  ];
}
