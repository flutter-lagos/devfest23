import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_theme.dart';

class DevFestTheme extends ThemeExtension<DevFestTheme> {
  /// Create and register new themes here
  final DevfestTextTheme? textTheme;
  final Color? backgroundColor;

  static DevFestTheme of(BuildContext context) =>
      Theme.of(context).extension<DevFestTheme>()!;

  const DevFestTheme({this.textTheme, this.backgroundColor});

  const DevFestTheme.light()
      : this(
          backgroundColor: DevfestColors.background,
        );

  const DevFestTheme.dark()
      : this(
          backgroundColor: DevfestColors.darkbackground,
        );

  @override
  ThemeExtension<DevFestTheme> copyWith() {
    // TODO: implement lerp
    return const DevFestTheme();
  }

  @override
  DevFestTheme lerp(DevFestTheme? other, double t) {
    if (other is! DevFestTheme) return this;
    return DevFestTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textTheme: textTheme?.lerp(other.textTheme, t),
    );
  }
}
