import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:show_flutter/features/authentication/repository/authentication_repository.dart';
import 'package:show_flutter/features/authentication/views/home_screen.dart';
import 'package:show_flutter/features/authentication/views/login_screen.dart';
import 'package:show_flutter/features/authentication/views/sign_up_screen.dart';
import 'package:show_flutter/features/settings/views/settings_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: HomeScreen.routeURL,
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepository).isLoggedIn;
      if (!isLoggedIn) {
        if (state.subloc != SignUpScreen.routeURL &&
            state.subloc != LoginScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: HomeScreen.routeURL,
        name: HomeScreen.routeName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: SettingsScreen.routeName,
        path: SettingsScreen.routeURL,
        builder: (context, state) => const SettingsScreen(),
      )
    ],
  );
});
