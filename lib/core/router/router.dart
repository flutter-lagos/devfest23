import 'package:collection/collection.dart';
import 'package:devfest23/core/router/routes.dart';
import 'package:devfest23/features/onboarding/pages/authentication.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/pages/home.dart';
import '../../features/onboarding/pages/onboarding.dart';
import '../../features/splash/splash.dart';

enum TabItem { home, schedule, speakers, favourites, more }

class AppRouter {
  AppRouter(WidgetRef ref) {
    mainRouter = _getRouter(ref);
  }

  static String initialLocation = RoutePaths.app;

  late GoRouter mainRouter;

  bool showOnboarding(GoRouterState state, WidgetRef ref) {
    // TODO: Implement onboarding screen checks
    return true;
  }

  GoRouter _getRouter(WidgetRef ref) => GoRouter(
        initialLocation: initialLocation,
        debugLogDiagnostics: true,
        redirect: (context, state) {
          return null;
        },
        routes: [
          GoRoute(
            path: RoutePaths.onboarding,
            name: RouteNames.onboarding,
            redirect: (context, state) {
              if (showOnboarding(state, ref)) {
                return null;
              }
              final tabId = state.pathParameters['tab'];
              return '/app/${tabId ?? TabItem.home.name}';
            },
            builder: (context, state) => const OnboardingPage(),
            routes: [
              GoRoute(
                path: RoutePaths.auth,
                name: RouteNames.auth,
                builder: (context, state) {
                  return const AuthenticationPage();
                },
              ),
              GoRoute(
                path: '${RoutePaths.auth}/:state',
                builder: (context, state) {
                  final stateId = state.pathParameters['state'];
                  AuthState? authState;

                  if (stateId != null) {
                    authState = AuthState.values.firstWhereOrNull(
                      (stateItem) =>
                          stateItem == AuthState.values.byName(stateId),
                    );
                  }
                  return AuthenticationPage(authState: authState);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/',
            builder: (context, state) => const SplashPage(),
          ),
          GoRoute(
            path: '/app/:tab',
            name: RouteNames.home,
            builder: (context, state) {
              final tabId = state.pathParameters['tab'];
              final tabItem = TabItem.values.firstWhere(
                (tabItem) => tabItem == TabItem.values.byName(tabId!),
                orElse: (() => throw Exception('Tab not found: $tabId')),
              );

              return AppHome(key: state.pageKey, initialTab: tabItem);
            },
          ),
        ],
      );
}
