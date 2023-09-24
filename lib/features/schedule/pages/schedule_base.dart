import '../../../core/router/routes.dart';
import 'schedule.dart';
import 'package:flutter/material.dart';
import 'package:regex_router/regex_router.dart';

import '../../../core/enums/devfest_day.dart';
import '../../../core/router/module_provider.dart';
import '../../../core/router/navigator.dart';
import 'session.dart';

scheduleRouter(DevfestDay initialDay) => RegexRouter.create({
      "/": (context, args) => SchedulePage(initialDay: initialDay),
      "${RoutePaths.session}/:id": (context, args) {
        return const SessionPage();
      }
    });

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key, this.initialDay});

  final DevfestDay? initialDay;

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ModuleProvider(
      module: Module.schedule,
      child: WillPopScope(
        onWillPop: () async {
          final navState = AppNavigator.getKey(Module.schedule).currentState;
          if (navState != null && navState.canPop()) {
            navState.pop();
            return false; // We handled the popping manually
          }
          return true; // Allow default behavior
        },
        child: Navigator(
          key: AppNavigator.getKey(Module.schedule),
          onUnknownRoute: (settings) => MaterialPageRoute(
            settings: settings,
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No home route defined for ${settings.name}'),
              ),
            ),
          ),
          onGenerateRoute: scheduleRouter(widget.initialDay ?? DevfestDay.day1)
              .generateRoute,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
