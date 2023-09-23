import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final TextStyle? button;

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
    this.button,
  });

  const DevfestTextTheme.fallback()
      : this(
          headline01: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 52,
            fontWeight: FontWeight.w700,
          ),
          headline02: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
          headline03: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
          headline04: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          headline05: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          title01: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
          title02: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          body01: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          body02: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          body03: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          body04: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          body05: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          button: const TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        );

  DevfestTextTheme.responsive()
      : this(
          headline01: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 52.sp,
            fontWeight: FontWeight.w700,
          ),
          headline02: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 40.sp,
            fontWeight: FontWeight.w700,
          ),
          headline03: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 32.sp,
            fontWeight: FontWeight.w700,
          ),
          headline04: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
          ),
          headline05: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          title01: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 26.sp,
            fontWeight: FontWeight.w600,
          ),
          title02: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
          ),
          body01: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
          ),
          body02: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          body03: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          body04: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          body05: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
          button: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        );

  @override
  DevfestTextTheme copyWith({
    TextStyle? headline01,
    TextStyle? headline02,
    TextStyle? headline03,
    TextStyle? headline04,
    TextStyle? headline05,
    TextStyle? title01,
    TextStyle? title02,
    TextStyle? body01,
    TextStyle? body02,
    TextStyle? body03,
    TextStyle? body04,
    TextStyle? body05,
    TextStyle? button,
  }) {
    return DevfestTextTheme(
      headline01: headline01 ?? this.headline01,
      headline02: headline02 ?? this.headline02,
      headline03: headline03 ?? this.headline03,
      headline04: headline04 ?? this.headline04,
      headline05: headline05 ?? this.headline05,
      title01: title01 ?? this.title01,
      title02: title02 ?? this.title02,
      body01: body01 ?? this.body01,
      body02: body02 ?? this.body02,
      body03: body03 ?? this.body03,
      body04: body04 ?? this.body04,
      body05: body05 ?? this.body05,
      button: button ?? this.button,
    );
  }

  @override
  DevfestTextTheme lerp(DevfestTextTheme? other, double t) {
    if (other is! DevfestTextTheme) return this;
    return DevfestTextTheme(
      headline01: TextStyle.lerp(headline01, other.headline01, t),
      headline02: TextStyle.lerp(headline02, other.headline02, t),
      headline03: TextStyle.lerp(headline03, other.headline03, t),
      headline04: TextStyle.lerp(headline04, other.headline04, t),
      headline05: TextStyle.lerp(headline05, other.headline05, t),
      title01: TextStyle.lerp(title01, other.title01, t),
      title02: TextStyle.lerp(title02, other.title02, t),
      body01: TextStyle.lerp(body01, other.body01, t),
      body02: TextStyle.lerp(body02, other.body02, t),
      body03: TextStyle.lerp(body03, other.body03, t),
      body04: TextStyle.lerp(body04, other.body04, t),
      body05: TextStyle.lerp(body05, other.body05, t),
      button: TextStyle.lerp(button, other.button, t),
    );
  }
}
