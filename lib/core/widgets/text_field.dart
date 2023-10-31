import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/themes/text_field_theme.dart';
import 'package:devfest23/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DevfestTextFormField extends StatelessWidget {
  const DevfestTextFormField({
    super.key,
    this.title,
    this.controller,
    this.hint,
    this.info,
    TextInputType? keyboardType,
    Color? iconColor,
    this.onChanged,
    this.validator,
    this.textInputAction,
  })  : keyboardType = keyboardType ?? TextInputType.text,
        iconColor = iconColor ?? DevfestColors.grey0;
  final String? title;
  final String? info;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Color iconColor;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final textFieldTheme = DevFestTheme.of(context).textFieldTheme ??
        const DevfestTextFieldTheme.light();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (title != null)
              Text(
                title!,
                style: DevFestTheme.of(context).textTheme?.body04,
              ),
            if (info != null)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: iconColor,
                    size: 11,
                  ),
                  (Constants.smallVerticalGutter / 2).horizontalSpace,
                  Text(
                    info!,
                    style: DevFestTheme.of(context).textTheme?.body05,
                  ),
                ],
              )
          ],
        ),
        Constants.smallVerticalGutter.verticalSpace,
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator,
          textInputAction: textInputAction,
          cursorColor: DevFestTheme.of(context).onBackgroundColor,
          style: DevFestTheme.of(context).textFieldTheme?.style,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textFieldTheme.hintStyle,
            border: textFieldTheme.border,
            enabledBorder: textFieldTheme.border,
            focusedBorder: textFieldTheme.focusedBorder,
          ),
        ),
        Constants.largeVerticalGutter.verticalSpace,
      ],
    );
  }
}
