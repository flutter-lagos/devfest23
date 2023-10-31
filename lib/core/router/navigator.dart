import 'package:flutter/cupertino.dart';

import 'module_provider.dart';
import 'router.dart';

// Context extension
extension NavigatorContextExtension on BuildContext {
  Future push(Widget view, {String? routeName}) {
    final Module module = ModuleExtension.moduleOf(this);
    return AppNavigator.push(view, routeName: routeName, module: module);
  }

  void pop({Object? result}) {
    final Module module = ModuleExtension.moduleOf(this);
    return AppNavigator.pop(result: result, module: module);
  }

  Future go(String route, {Object? extra}) {
    final Module module = ModuleExtension.moduleOf(this);
    return AppNavigator.pushNamed(route, module: module, arguments: extra);
  }

  Future goReplace(String route, {Object? extra}) {
    final Module module = ModuleExtension.moduleOf(this);
    return AppNavigator.pushNamedReplacement(route,
        module: module, arguments: extra);
  }

  Future pushNamedAndClear(String route) {
    return AppNavigator.pushNamedAndClear(route);
  }
}

// Module extension
extension ModuleExtension on Module {
  static Module moduleOf(BuildContext context) {
    return ModuleProvider.of(context);
  }
}

abstract class AppNavigator {
  static final _generalNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'General Navigator Key');
  static final _homeNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'Home Navigator Key');
  static final _scheduleNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'Schedule Navigator Key');
  static final _speakersNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'Speakers Navigator Key');
  static final _favouritesNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'Rsvp Navigator Key');
  static final _moreNavKey =
      GlobalKey<NavigatorState>(debugLabel: 'More Navigator Key');

  // Helper to reduce repetition and safely retrieve navigator state
  static NavigatorState? _getNavigatorState(Module module) {
    return getKey(module).currentState;
  }

  static GlobalKey<NavigatorState> getKey(Module module) {
    switch (module) {
      case Module.home:
        return _homeNavKey;
      case Module.schedule:
        return _scheduleNavKey;
      case Module.speakers:
        return _speakersNavKey;
      case Module.favourites:
        return _favouritesNavKey;
      case Module.more:
        return _moreNavKey;
      default:
        return _generalNavKey;
    }
  }

  static void popUntilIsFirst({Module module = Module.general}) {
    _getNavigatorState(module)?.popUntil((route) => route.isFirst);
  }

  static Future push(Widget view,
      {String? routeName, Module module = Module.general}) {
    final navState = _getNavigatorState(module);
    if (navState != null) {
      return navState.push(AppRouter.getPageRoute(
        settings: RouteSettings(name: routeName),
        view: view,
      ));
    }
    return Future.error('Navigator state is null');
  }

  static Future pushNamed(String route,
      {Object? arguments, Module module = Module.general}) {
    final navState = _getNavigatorState(module);
    if (navState != null) {
      return navState.pushNamed(route, arguments: arguments);
    }
    return Future.error('Navigator state is null');
  }

  static Future pushNamedReplacement(String route,
      {Object? arguments, Module module = Module.general}) {
    final navState = _getNavigatorState(module);
    if (navState != null) {
      return navState.pushReplacementNamed(route, arguments: arguments);
    }
    return Future.error('Navigator state is null');
  }

  static Future pushNamedAndClear(String route, {Object? arguments}) {
    final navState = _getNavigatorState(Module.general);
    if (navState != null) {
      return navState.pushNamedAndRemoveUntil(route, (route) => false,
          arguments: arguments);
    }
    return Future.error('Navigator state is null');
  }

  static Future<bool> maybePop([Object? result]) {
    final navState = _getNavigatorState(Module.general);
    if (navState != null) {
      return navState.maybePop(result);
    }
    return Future.value(false);
  }

  static void pop({Object? result, Module module = Module.general}) {
    final navState = _getNavigatorState(module);
    if (navState != null && navState.canPop()) {
      navState.pop(result);
    } else if (_generalNavKey.currentState?.canPop() ?? false) {
      _generalNavKey.currentState?.pop(result);
    }
  }
}
