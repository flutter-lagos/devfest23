import 'package:devfest23/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  DevfestBottomNavTheme.light()
      : this._(
          labelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.27,
            fontFamily: 'Google Sans',
          ),
          selectedColor: DevfestColors.blue,
          unselectedColor: DevfestColors.grey70,
        );

  DevfestBottomNavTheme.dark()
      : this._(
          labelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Google Sans',
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
