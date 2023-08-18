import 'package:devfest23/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../core/images.dart';
import '../../../core/providers/providers.dart';
import '../../../core/themes/themes.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Sponsor chip',
    type: DevfestSponsorChips,
    designLink:
        'https://www.figma.com/file/CCnX5Sh86ILqRn7ng6Shlr/DevFest-Jordan-Year---Mobile-App?node-id=1591%3A1213&mode=dev')
Widget devfestSponsorTile(BuildContext context) {
  return Material(
    color: DevFestTheme.of(context).backgroundColor,
    child: SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.horizontalMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SponsorsChip(image: AppImages.googleLogo),
          ],
        ),
      ),
    ),
  );
}

class SponsorsChip extends ConsumerWidget {
  const SponsorsChip({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    return Container(
      decoration: ShapeDecoration(
        color: isDark ? const Color(0xFF1C1C1C) : const Color(0xFFFFFAEB),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: isDark ? const Color(0xFF1B1B1B) : const Color(0xFFE6E6E6),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(right: 8),
      child: Image(image: AssetImage(image)),
    );
  }
}
