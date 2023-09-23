import 'package:devfest23/core/router/routes.dart';
import 'package:devfest23/features/favourites/pages/favourites.dart';
import 'package:flutter/material.dart';
import 'package:regex_router/regex_router.dart';

import '../../../core/enums/devfest_day.dart';
import '../../../core/router/module_provider.dart';
import '../../../core/router/navigator.dart';
import '../../schedule/pages/session.dart';

favouriteRouter(DevfestDay initialDay) => RegexRouter.create({
      "/": (context, args) => FavouritesPage(initialDay: initialDay),
      "${RoutePaths.session}/:id": (context, args) {
        return const SessionPage();
      }
    });

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key, this.initialDay});

  final DevfestDay? initialDay;

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ModuleProvider(
      module: Module.favourites,
      child: Navigator(
        key: AppNavigator.getKey(Module.favourites),
        onUnknownRoute: (settings) => MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No favourite route defined for ${settings.name}'),
            ),
          ),
        ),
        onGenerateRoute:
            favouriteRouter(widget.initialDay ?? DevfestDay.day1).generateRoute,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
