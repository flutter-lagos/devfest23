import 'package:devfest23/core/themes/colors.dart';
import 'package:flutter/material.dart';

@immutable
class DevfestBottomNavTheme extends ThemeExtension<DevfestBottomNavTheme> {
  final TextStyle labelStyle;
  final Color selectedColor;
  final Color unselectedColor;

  const DevfestBottomNavTheme._({
    required this.labelStyle,
    required this.selectedColor,
    required this.unselectedColor,
  });

  const DevfestBottomNavTheme.light()
      : this._(
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.27,
          ),
          selectedColor: DevfestColors.blue,
          unselectedColor: DevfestColors.grey70,
        );

  const DevfestBottomNavTheme.dark()
      : this._(
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.27,
          ),
          selectedColor: DevfestColors.blue,
          unselectedColor: DevfestColors.grey70,
        );

  @override
  DevfestBottomNavTheme copyWith({
    TextStyle? labelStyle,
    Color? selectedColor,
    Color? unselectedColor,
  }) {
    return DevfestBottomNavTheme._(
      labelStyle: labelStyle ?? this.labelStyle,
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
    );
  }

  @override
  DevfestBottomNavTheme lerp(
      covariant ThemeExtension<DevfestBottomNavTheme>? other, double t) {
    if (other is! DevfestBottomNavTheme) return this;

    return DevfestBottomNavTheme._(
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t)!,
      unselectedColor: Color.lerp(unselectedColor, other.unselectedColor, t)!,
    );
  }
}
