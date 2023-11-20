import '../../../core/router/module_provider.dart';
import '../../../core/router/navigator.dart';
import 'more.dart';
import '../../profile/pages/profile.dart';
import 'package:flutter/material.dart';

class MoreView extends StatefulWidget {
  const MoreView({super.key});

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    return ModuleProvider(
      module: Module.more,
      child: PopScope(
        canPop: canPop,
        onPopInvoked: (didPop) {
          final navState = AppNavigator.getKey(Module.more).currentState;
          if (navState != null && navState.canPop()) {
            AppNavigator.pop(module: Module.more);
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
      ),
    );
  }
}
