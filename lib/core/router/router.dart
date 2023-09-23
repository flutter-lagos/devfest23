import 'routes.dart';
import '../../features/agenda/pages/agenda_base.dart';
import '../../features/favourites/pages/favourites_base.dart';
import '../../features/schedule/pages/schedule_base.dart';
import '../../features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:regex_router/regex_router.dart';
import '../../features/home/pages/home.dart';
import '../../features/more/pages/more_base.dart';
import '../../features/onboarding/pages/authentication.dart';
import '../../features/onboarding/pages/onboarding.dart';

import 'package:collection/collection.dart';

import '../../features/speakers/page/speakers_base.dart';
import '../enums/devfest_day.dart';
import '../enums/tab_item.dart';

final router = RegexRouter.create({
  // Access "object" arguments from `NavigatorState.pushNamed`.
  "${RoutePaths.onboarding}/${RoutePaths.auth}(\\?result=(?<result>success|pending|failed))?":
      (context, args) {
    final String? stateId = args.pathArgs['result'];
    AuthState? authState;
    if (stateId != null) {
      authState = AuthState.values.firstWhereOrNull(
        (stateItem) => stateItem == AuthState.values.byName(stateId),
      );
    }
    return AuthenticationPage(authState: authState);
  },
  'app/:tab': (context, args) {
    final tabId = args.pathArgs['tab'];
    final tabItem = TabItem.values.firstWhere(
      (tabItem) => tabItem == TabItem.values.byName(tabId!),
      orElse: (() => throw Exception('Tab not found: $tabId')),
    );

    const dayItem = DevfestDay.day1;

    final page = switch (tabItem) {
      TabItem.home => const AgendaView(initialDay: dayItem),
      TabItem.schedule => const ScheduleView(initialDay: dayItem),
      TabItem.speakers => const SpeakersView(initialDay: dayItem),
      TabItem.favourites => const FavouritesView(initialDay: dayItem),
      TabItem.more => const MoreView(),
    };

    return AppHome(
      key: page.key,
      tab: tabItem,
    );
  }
});

abstract class AppRouter {
  static Map<String, Widget Function(BuildContext)> get routes {
    return <String, WidgetBuilder>{
      RoutePaths.app: (context) => const SplashPage(),
      RoutePaths.onboarding: (context) => const OnboardingPage(),
    };
  }

  static Route<dynamic>? generateRoutes(RouteSettings settings) {
    return router.generateRoute(settings);
  }

  static PageRoute<dynamic> getPageRoute({
    required RouteSettings settings,
    required Widget view,
  }) {
    return MaterialPageRoute(settings: settings, builder: (_) => view);
  }
}
