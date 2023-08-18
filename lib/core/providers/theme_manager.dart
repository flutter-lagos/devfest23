import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManagerNotifier extends StateNotifier<ThemeMode> {
  ThemeManagerNotifier() : super(ThemeMode.system);

  static const _themeModeKey = 'theme_mode';

  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, theme.name);

    state = theme;
  }

  Future<void> getThemeMode(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeName = prefs.getString(_themeModeKey);

    if (!mounted) return;

    await updateThemeMode(ThemeMode.values
            .firstWhereOrNull((element) => element.name == themeModeName) ??
        _getThemeFromBrightness(context));
  }

  ThemeMode _getThemeFromBrightness(BuildContext context) {
    return MediaQuery.platformBrightnessOf(context) == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}
