import 'package:devfest23/core/themes/bottom_nav_theme.dart';
import 'package:devfest23/core/themes/button_theme.dart';
import 'package:devfest23/core/themes/outlined_button_theme.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_theme.dart';

class DevFestTheme extends ThemeExtension<DevFestTheme> {
  /// Create and register new themes here
  final DevfestTextTheme? textTheme;
  final DevfestButtonTheme? buttonTheme;
  final DevfestOutlinedButtonTheme? outlinedButtonTheme;
  final DevfestBottomNavTheme? bottomNavTheme;
  final Color? backgroundColor;
  final Color? onBackgroundColor;

  static DevFestTheme of(BuildContext context) =>
      Theme.of(context).extension<DevFestTheme>()!;

  const DevFestTheme({
    this.textTheme,
    this.backgroundColor,
    this.onBackgroundColor,
    this.outlinedButtonTheme,
    this.bottomNavTheme,
    this.buttonTheme,
  });

  const DevFestTheme.light()
      : this(
          backgroundColor: DevfestColors.background,
          onBackgroundColor: DevfestColors.grey0,
          buttonTheme: const DevfestButtonTheme.light(),
          outlinedButtonTheme: const DevfestOutlinedButtonTheme.light(),
          bottomNavTheme: const DevfestBottomNavTheme.light(),
          textTheme: const DevfestTextTheme.fallback(),
        );

  const DevFestTheme.dark()
      : this(
          backgroundColor: DevfestColors.darkbackground,
          onBackgroundColor: DevfestColors.background,
          buttonTheme: const DevfestButtonTheme.dark(),
          outlinedButtonTheme: const DevfestOutlinedButtonTheme.dark(),
          bottomNavTheme: const DevfestBottomNavTheme.dark(),
          textTheme: const DevfestTextTheme.fallback(),
        );

  @override
  DevFestTheme copyWith({
    DevfestTextTheme? textTheme,
    DevfestButtonTheme? buttonTheme,
    DevfestOutlinedButtonTheme? outlinedButtonTheme,
    DevfestBottomNavTheme? bottomNavTheme,
  }) {
    return DevFestTheme(
      textTheme: textTheme ?? this.textTheme,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      outlinedButtonTheme: outlinedButtonTheme ?? this.outlinedButtonTheme,
      bottomNavTheme: bottomNavTheme ?? this.bottomNavTheme,
    );
  }

  @override
  DevFestTheme lerp(DevFestTheme? other, double t) {
    if (other is! DevFestTheme) return this;
    return DevFestTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textTheme: textTheme?.lerp(other.textTheme, t),
      buttonTheme: buttonTheme?.lerp(other.buttonTheme, t),
      outlinedButtonTheme:
          outlinedButtonTheme?.lerp(other.outlinedButtonTheme, t),
      bottomNavTheme: bottomNavTheme?.lerp(other.bottomNavTheme, t),
    );
  }
}
