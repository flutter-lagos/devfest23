import 'package:devfest23/core/router/routes.dart';
import 'package:devfest23/features/speakers/page/speakers.dart';
import 'package:flutter/material.dart';
import 'package:regex_router/regex_router.dart';

import '../../../core/enums/devfest_day.dart';
import '../../../core/router/module_provider.dart';
import '../../../core/router/navigator.dart';
import 'speaker_details.dart';

speakerRouter(DevfestDay initialDay) => RegexRouter.create({
      "/": (context, args) => SpeakersPage(initialDay: initialDay),
      "${RoutePaths.speakers}/:id": (context, args) {
        return const SpeakerDetailsPage();
      }
    });

class SpeakersView extends StatefulWidget {
  const SpeakersView({super.key, this.initialDay});

  final DevfestDay? initialDay;

  @override
  State<SpeakersView> createState() => _SpeakersViewState();
}

class _SpeakersViewState extends State<SpeakersView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ModuleProvider(
      module: Module.speakers,
      child: Navigator(
        key: AppNavigator.getKey(Module.speakers),
        onUnknownRoute: (settings) => MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No speaker route defined for ${settings.name}'),
            ),
          ),
        ),
        onGenerateRoute:
            speakerRouter(widget.initialDay ?? DevfestDay.day1).generateRoute,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
