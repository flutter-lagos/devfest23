import 'package:devfest23/core/themes/colors.dart';
import 'package:flutter/material.dart';

@immutable
class DevfestTextFieldTheme extends ThemeExtension<DevfestTextFieldTheme> {
  final InputBorder border;
  final InputBorder focusedBorder;
  final TextStyle hintStyle;
  final TextStyle style;

  const DevfestTextFieldTheme._(
      {required this.border,
      required this.focusedBorder,
      required this.hintStyle,
      required this.style});

  const DevfestTextFieldTheme.light()
      : this._(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: DevfestColors.grey90, width: 1.5),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: DevfestColors.grey40, width: 1.5),
          ),
          hintStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: DevfestColors.grey40,
          ),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: DevfestColors.grey40,
          ),
        );

  const DevfestTextFieldTheme.dark()
      : this._(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: DevfestColors.grey90),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: DevfestColors.grey100),
          ),
          hintStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: DevfestColors.grey100,
          ),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: DevfestColors.grey100,
          ),
        );

  @override
  ThemeExtension<DevfestTextFieldTheme> copyWith({
    InputBorder? border,
    InputBorder? focusedBorder,
    TextStyle? hintStyle,
    TextStyle? style,
  }) {
    return DevfestTextFieldTheme._(
      border: border ?? this.border,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      hintStyle: hintStyle ?? this.hintStyle,
      style: style ?? this.style,
    );
  }

  @override
  ThemeExtension<DevfestTextFieldTheme> lerp(
      covariant ThemeExtension<DevfestTextFieldTheme>? other, double t) {
    return this;
  }
}
