import 'package:collection/collection.dart';
import 'package:devfest23/core/enums/devfest_day.dart';
import 'package:devfest23/core/router/routes.dart';
import 'package:devfest23/features/home/pages/agenda.dart';
import 'package:devfest23/features/home/pages/favourites.dart';
import 'package:devfest23/features/home/pages/more.dart';
import 'package:devfest23/features/home/pages/schedule.dart';
import 'package:devfest23/features/home/pages/speaker_details.dart';
import 'package:devfest23/features/home/pages/speakers.dart';
import 'package:devfest23/features/onboarding/pages/authentication.dart';
import 'package:devfest23/features/session/pages/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/pages/home.dart';
import '../../features/onboarding/pages/onboarding.dart';
import '../../features/splash/splash.dart';
import '../enums/tab_item.dart';

class AppRouter {
  AppRouter(WidgetRef ref) {
    mainRouter = _getRouter(ref);
  }

  static String initialLocation = RoutePaths.app;
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey();

  late GoRouter mainRouter;

  bool showOnboarding(GoRouterState state, WidgetRef ref) {
    // TODO: Implement onboarding screen checks
    return true;
  }

  GoRouter _getRouter(WidgetRef ref) => GoRouter(
        initialLocation: initialLocation,
        navigatorKey: _rootNavigatorKey,
        debugLogDiagnostics: kDebugMode,
        redirect: (context, state) {
          return null;
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: RoutePaths.onboarding,
            name: RouteNames.onboarding,
            redirect: (context, state) {
              if (showOnboarding(state, ref)) {
                return null;
              }
              final tabId = state.pathParameters['tab'];
              final dayId = state.pathParameters['day'];
              return '/app/${tabId ?? TabItem.home.name}/${dayId ?? DevfestDay.day1}';
            },
            builder: (context, state) => const OnboardingPage(),
            routes: [
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: RoutePaths.auth,
                builder: (context, state) {
                  final stateId = state.uri.queryParameters['result'];
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
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => const SplashPage(),
          ),
          ShellRoute(
            // path: '/app/:tab/:day',
            // name: RouteNames.home,
            parentNavigatorKey: _rootNavigatorKey,
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              final tabId = state.pathParameters['tab'];
              final tabItem = TabItem.values.firstWhere(
                (tabItem) => tabItem == TabItem.values.byName(tabId!),
                orElse: (() => throw Exception('Tab not found: $tabId')),
              );

              return AppHome(
                key: state.pageKey,
                tab: tabItem,
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: '/app/:tab/:day',
                parentNavigatorKey: _shellNavigatorKey,
                name: RouteNames.home,
                builder: (context, state) {
                  final tabId = state.pathParameters['tab'];
                  final tabItem = TabItem.values.firstWhere(
                    (tabItem) => tabItem == TabItem.values.byName(tabId!),
                    orElse: (() => throw Exception('Tab not found: $tabId')),
                  );
                  final dayId = state.pathParameters['day'];
                  final dayItem = DevfestDay.values.firstWhere(
                      (dayItem) => dayItem == DevfestDay.values.byName(dayId!),
                      orElse: (() => throw Exception('Day not found: $dayId')));

                  return switch (tabItem) {
                    TabItem.home => AgendaPage(initialDay: dayItem),
                    TabItem.schedule => SchedulePage(initialDay: dayItem),
                    TabItem.speakers => SpeakersPage(initialDay: dayItem),
                    TabItem.favourites => FavouritesPage(initialDay: dayItem),
                    TabItem.more => const MorePage(),
                  };
                },
              ),
              GoRoute(
                path: '${RoutePaths.session}/:tab',
                name: RouteNames.session,
                parentNavigatorKey: _shellNavigatorKey,
                builder: (context, state) {
                  return const SessionPage();
                },
              ),
              GoRoute(
                path: '${RoutePaths.speakers}/:tab/:id',
                builder: (context, state) {
                  final speakerId = state.uri.queryParameters['id'];

                  if (speakerId != null) {
                    return const SpeakerDetailsPage();
                  }
                  return const SpeakerDetailsPage();
                },
              ),
            ],
          ),
        ],
      );
}
