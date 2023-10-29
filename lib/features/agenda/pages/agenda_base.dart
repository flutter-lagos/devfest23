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
      "${RoutePaths.session}/:id": (context, args) {
        final id = int.parse(args.pathArgs['id']!);
        return SessionPage(sessionIndex: id);
      },
      "${RoutePaths.speakers}/:id": (context, args) {
        final id = int.parse(args.pathArgs['id']!);
        return SpeakerDetailsPage(speakerIndex: id);
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
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ModuleProvider(
      module: Module.home,
      child: WillPopScope(
        onWillPop: () async {
          final navState = AppNavigator.getKey(Module.home).currentState;
          if (navState != null && navState.canPop()) {
            navState.pop();
            return false; // We handled the popping manually
          }
          return true; // Allow default behavior
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
