import 'package:devfest23/core/data/data.dart';

import '../../../core/router/routes.dart';
import 'speakers.dart';
import 'package:flutter/material.dart';
import 'package:regex_router/regex_router.dart';

import '../../../core/enums/devfest_day.dart';
import '../../../core/router/module_provider.dart';
import '../../../core/router/navigator.dart';
import 'speaker_details.dart';

speakerRouter(DevfestDay initialDay) => RegexRouter.create({
      "/": (context, args) => SpeakersPage(initialDay: initialDay),
      RoutePaths.speakers: (context, args) {
        return SpeakerDetailsPage(speaker: args.body as Speaker);
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
  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ModuleProvider(
      module: Module.speakers,
      child: PopScope(
        canPop: canPop,
        onPopInvoked: (_) {
          final navState = AppNavigator.getKey(Module.speakers).currentState;
          if (navState != null && navState.canPop()) {
            AppNavigator.pop(module: Module.speakers);
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
