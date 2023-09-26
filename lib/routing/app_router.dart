import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadowinner_master_settings/main.dart';
import 'package:shadowinner_master_settings/routing/go_router_refresh_stream.dart';
import 'package:shadowinner_master_settings/routing/not_found_screen.dart';
import 'package:shadowinner_master_settings/screens/settings_master/onboarding_screen.dart';
import 'package:shadowinner_master_settings/services/auth.dart';

enum AppRoute { home, login }

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.fullPath == '/login') {
          return '/';
        }
      } else {
        return '/login';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => OnboardingScreen(),
        routes: [
          GoRoute(
            path: 'login',
            name: AppRoute.login.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const WelcomePage(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
