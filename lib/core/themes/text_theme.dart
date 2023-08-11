import 'package:flutter/material.dart';

@immutable
class DevfestTextTheme extends ThemeExtension<DevfestTextTheme> {
  final TextStyle? headline01;
  final TextStyle? headline02;
  final TextStyle? headline03;
  final TextStyle? headline04;
  final TextStyle? headline05;
  final TextStyle? title01;
  final TextStyle? title02;
  final TextStyle? body01;
  final TextStyle? body02;
  final TextStyle? body03;
  final TextStyle? body04;
  final TextStyle? body05;

  const DevfestTextTheme({
    this.headline01,
    this.headline02,
    this.headline03,
    this.headline04,
    this.headline05,
    this.title01,
    this.title02,
    this.body01,
    this.body02,
    this.body03,
    this.body04,
    this.body05,
  });

  @override
  DevfestTextTheme copyWith() {
    // TODO: implement lerp
    return const DevfestTextTheme();
  }

  @override
  DevfestTextTheme lerp(DevfestTextTheme? other, double t) {
    if (other is! DevfestTextTheme) return this;
    // TODO: implement lerp
    return const DevfestTextTheme();
  }
}
