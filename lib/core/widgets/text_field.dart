import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/themes/text_field_theme.dart';
import 'package:devfest23/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWrapper extends StatelessWidget {
  const TextFieldWrapper(
      {
        super.key,
        required this.title,
      required this.controller,
      required this.hint,
      required this.info,
      TextInputType? keyboardType,
      Color? iconColor
      })
      : keyboardType = keyboardType ?? TextInputType.text,
      iconColor=iconColor?? DevfestColors.grey0
      ;
  final String title;
  final String info;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final textFieldTheme = DevFestTheme.of(context).textFieldTheme ??
        const DevfestTextFieldTheme.light();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: DevFestTheme.of(context).textTheme?.body04,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(Icons.info_outline,color:iconColor ,),
                Text(
                  info,
                  style: DevFestTheme.of(context).textTheme?.body05,
                ),
              ],
            )
          ],
        ),
        Constants.smallVerticalGutter.verticalSpace,
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: textFieldTheme.hintStyle,
              border: textFieldTheme.border,
              focusedBorder: textFieldTheme.focusedBorder),
        ),
        Constants.largeVerticalGutter.verticalSpace,
      ],
    );
  }
}
