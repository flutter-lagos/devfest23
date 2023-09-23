import 'package:devfest23/core/router/module_provider.dart';
import 'package:devfest23/core/router/navigator.dart';
import 'package:devfest23/features/more/pages/more.dart';
import 'package:devfest23/features/profile/pages/profile.dart';
import 'package:flutter/material.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return ModuleProvider(
      module: Module.more,
      child: Navigator(
        key: AppNavigator.getKey(Module.more),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => const MorePage(),
              );
            case '/profile':
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => const ProfilePage(),
              );
            default:
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No more route defined for ${settings.name}'),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
