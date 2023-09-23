import '../../../core/constants.dart';
import '../../../core/themes/theme_data.dart';
import '../../../core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'More Tile', type: DevfestTiles)
Widget devfestMoreTile(BuildContext context) {
  return Material(
    color: DevFestTheme.of(context).backgroundColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MoreTile(
          leading: const Icon(Icons.account_circle_outlined),
          title: const Text('Profile'),
          trailing: const Icon(Icons.chevron_right),
          onPressed: () {},
        ),
      ],
    ),
  );
}

class MoreTile extends StatelessWidget {
  const MoreTile({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.onPressed,
    this.titleStyle,
  });

  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? titleStyle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: Constants.kAnimationDur,
      style: titleStyle ??
          DevFestTheme.of(context).textTheme!.body02!.copyWith(
                color: DevFestTheme.of(context).onBackgroundColor,
                fontWeight: FontWeight.w500,
              ),
      child: IconTheme(
        data: IconThemeData(
          color: DevFestTheme.of(context).onBackgroundColor,
          weight: 600,
        ),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: Constants.verticalGutter),
            child: Row(
              children: [
                if (leading case final widget?) ...[
                  widget,
                  Constants.horizontalGutter.horizontalSpace,
                ],
                Expanded(child: title),
                if (trailing case final widget?) ...[
                  Constants.horizontalGutter.horizontalSpace,
                  widget,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
