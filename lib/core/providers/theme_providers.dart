import 'theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../themes/themes.dart';

final themeManagerProvider =
    StateNotifierProvider.autoDispose<ThemeManagerNotifier, ThemeMode>((ref) {
  return ThemeManagerNotifier();
});
final isDarkProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(themeManagerProvider) == ThemeMode.dark;
});

final textColorProvider = Provider.autoDispose<Color>((ref) {
  return ref.watch(themeManagerProvider) == ThemeMode.dark
      ? DevfestColors.background
      : DevfestColors.grey0;
});
