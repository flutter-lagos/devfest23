import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../core/themes/themes.dart';

class TitleTile extends ConsumerWidget {
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
  Widget build(BuildContext context, ref) {
    final color = ref.watch(isDarkProvider)
        ? backgroundColor
        : backgroundColor.withOpacity(0.2);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: const EdgeInsets.only(top: 20, bottom: 16),
      decoration: ShapeDecoration(
        color: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      child: Text.rich(
        TextSpan(
          text: emoji,
          style: DevFestTheme.of(context)
              .textTheme
              ?.body03
              ?.copyWith(color: DevfestColors.grey0),
          children: [
            const WidgetSpan(child: SizedBox(width: 4)),
            TextSpan(text: title)
          ],
        ),
      ),
    );
  }
}
