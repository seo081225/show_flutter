import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:show_flutter/constants/rotes.dart';
import 'package:show_flutter/features/authentication/repository/authentication_repository.dart';
import 'package:show_flutter/features/authentication/views/login_screen.dart';
import 'package:show_flutter/features/authentication/views/sign_up_screen.dart';
import 'package:show_flutter/features/main_navigation/main_navigation_screen.dart';
import 'package:show_flutter/features/settings/views/settings_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepository).isLoggedIn;
      if (!isLoggedIn) {
        if (state.subloc != Routes.SIGN_UP_PATH &&
            state.subloc != Routes.LOGIN_PATH) {
          return Routes.SIGN_UP_PATH;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        name: Routes.SIGN_UP_NAME,
        path: Routes.SIGN_UP_PATH,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: Routes.LOGIN_NAME,
        path: Routes.LOGIN_PATH,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: Routes.MAIN_TAB_NAME,
        path: Routes.MAIN_TAB_PATH,
        builder: (context, state) {
          final tab = state.params["tab"]!;
          return MainNavigationScreen(tab: tab);
        },
      ),
      GoRoute(
        name: Routes.SETTING_NAME,
        path: Routes.SETTING_PAHT,
        builder: (context, state) => const SettingsScreen(),
      )
    ],
  );
});
