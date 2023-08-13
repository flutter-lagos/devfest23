import 'package:flutter/material.dart';

import '../../../core/themes/themes.dart';

class TitleTile extends StatelessWidget {
  const TitleTile({
    super.key,
    required this.emoji,
    required this.title,
    required this.backgroundColor,
  });

  final String emoji;
  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: const EdgeInsets.only(top: 20, bottom: 16),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      child: RichText(
        text: TextSpan(
          text: emoji,
          style: DevFestTheme.of(context)
              .textTheme
              ?.body03
              ?.copyWith(color: DevFestTheme.of(context).onBackgroundColor),
          children: [
            const WidgetSpan(child: SizedBox(width: 4)),
            TextSpan(text: title)
          ],
        ),
      ),
    );
  }
}
