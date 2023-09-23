import 'package:devfest23/core/enums/devfest_day.dart';
import 'package:devfest23/core/router/module_provider.dart';
import 'package:devfest23/core/router/navigator.dart';
import 'package:devfest23/features/agenda/pages/agenda.dart';
import 'package:flutter/material.dart';
import 'package:regex_router/regex_router.dart';

import '../../../core/router/routes.dart';
import '../../speakers/page/speaker_details.dart';
import '../../schedule/pages/session.dart';

agendaRouter(DevfestDay initialDay) => RegexRouter.create({
      "/": (context, args) => AgendaPage(initialDay: initialDay),
      "${RoutePaths.session}/:id": (context, args) {
        return const SessionPage();
      },
      "${RoutePaths.speakers}/:id": (context, args) {
        return const SpeakerDetailsPage();
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
