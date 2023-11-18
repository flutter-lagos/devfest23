import 'package:devfest23/core/data/data.dart';

import '../../../core/enums/devfest_day.dart';
import '../../../core/router/module_provider.dart';
import '../../../core/router/navigator.dart';
import 'agenda.dart';
import 'package:flutter/material.dart';
import 'package:regex_router/regex_router.dart';

import '../../../core/router/routes.dart';
import '../../speakers/page/speaker_details.dart';
import '../../schedule/pages/session.dart';

agendaRouter(DevfestDay initialDay) => RegexRouter.create({
      "/": (context, args) => AgendaPage(initialDay: initialDay),
      RoutePaths.session: (context, args) {
        return SessionPage(session: args.body as Session);
      },
      RoutePaths.speakers: (context, args) {
        return SpeakerDetailsPage(speaker: args.body as Speaker);
      }
    });

class AgendaView extends StatefulWidget {
  const AgendaView({super.key, this.initialDay});

  final DevfestDay? initialDay;

  @override
  State<AgendaView> createState() => _AgendaViewState();
}

class _AgendaViewState extends State<AgendaView>
    with AutomaticKeepAliveClientMixin {
  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ModuleProvider(
      module: Module.home,
      child: PopScope(
        canPop: canPop,
        onPopInvoked: (_) {
          final navState = AppNavigator.getKey(Module.home).currentState;
          if (navState != null && navState.canPop()) {
            AppNavigator.pop(module: Module.home);
            setState(() {
              canPop = false;
            }); // We handled the popping manually
            return;
          }
          setState(() {
            canPop = true;
          }); // Allow default behavior
        },
        child: Navigator(
          key: AppNavigator.getKey(Module.home),
          onUnknownRoute: (settings) => MaterialPageRoute(
            settings: settings,
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No home route defined for ${settings.name}'),
              ),
            ),
          ),
          onGenerateRoute:
              agendaRouter(widget.initialDay ?? DevfestDay.day1).generateRoute,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
