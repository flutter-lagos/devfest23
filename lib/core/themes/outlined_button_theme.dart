import 'package:devfest23/core/themes/colors.dart';
import 'package:flutter/material.dart';

@immutable
class DevfestOutlinedButtonTheme
    extends ThemeExtension<DevfestOutlinedButtonTheme> {
  final OutlinedBorder shape;
  final Color outlineColor;
  final TextStyle textStyle;
  final Color iconColor;

  const DevfestOutlinedButtonTheme._({
    required this.shape,
    required this.outlineColor,
    required this.textStyle,
    required this.iconColor,
  });

  const DevfestOutlinedButtonTheme.light()
      : this._(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: DevfestColors.grey0),
            borderRadius: BorderRadius.all(Radius.circular(48)),
          ),
          outlineColor: DevfestColors.grey0,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: DevfestColors.grey0,
          ),
          iconColor: DevfestColors.grey0,
        );

  const DevfestOutlinedButtonTheme.dark()
      : this._(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: DevfestColors.grey100),
            borderRadius: BorderRadius.all(Radius.circular(48)),
          ),
          outlineColor: DevfestColors.grey100,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: DevfestColors.grey100,
          ),
          iconColor: DevfestColors.grey100,
        );

  @override
  DevfestOutlinedButtonTheme copyWith({
    OutlinedBorder? shape,
    Color? outlineColor,
    TextStyle? textStyle,
    Color? iconColor,
  }) {
    return DevfestOutlinedButtonTheme._(
      shape: shape ?? this.shape,
      outlineColor: outlineColor ?? this.outlineColor,
      textStyle: textStyle ?? this.textStyle,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  DevfestOutlinedButtonTheme lerp(
      covariant ThemeExtension<DevfestOutlinedButtonTheme>? other, double t) {
    if (other is! DevfestOutlinedButtonTheme) return this;

    return DevfestOutlinedButtonTheme._(
      shape: OutlinedBorder.lerp(shape, other.shape, t)!,
      outlineColor: Color.lerp(outlineColor, other.outlineColor, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
    );
  }
}
