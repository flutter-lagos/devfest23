import 'package:flutter/widgets.dart';

enum Module { general, home, schedule, speakers, favourites, more }

class ModuleProvider extends InheritedWidget {
  final Module module;

  const ModuleProvider({
    super.key,
    required this.module,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(ModuleProvider oldWidget) {
    return module != oldWidget.module;
  }

  static Module of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<ModuleProvider>()
            ?.module ??
        Module.general;
  }
}
