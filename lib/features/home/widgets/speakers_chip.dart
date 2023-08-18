import 'package:devfest23/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../core/images.dart';
import '../../../core/providers/providers.dart';
import '../../../core/themes/themes.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Speaker chip',
    type: DevfestSpeakerChips,
    designLink:
        'https://www.figma.com/file/CCnX5Sh86ILqRn7ng6Shlr/DevFest-Jordan-Year---Mobile-App?node-id=1591%3A1213&mode=dev')
Widget devfestSpeakerChip(BuildContext context) {
  return Material(
    color: DevFestTheme.of(context).backgroundColor,
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.horizontalMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpeakersChip(),
        ],
      ),
    ),
  );
}

class SpeakersChip extends ConsumerWidget {
  const SpeakersChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        color: isDark ? const Color(0xFFA8A3A3) : const Color(0xFF211212),
      ),
      padding: const EdgeInsets.only(top: 2, bottom: 4, left: 2, right: 4),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: const BoxDecoration(
          color: Color(0xFFF6EEEE),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Row(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: AssetImage(AppImages.devfestLogoLight),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(width: Constants.horizontalGutter),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Samuel Abada',
                    style: DevFestTheme.of(context)
                        .textTheme
                        ?.title02
                        ?.copyWith(color: DevfestColors.grey0),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Senior Mobile Developer, Cruise Nation',
                    style: DevFestTheme.of(context)
                        .textTheme
                        ?.body03
                        ?.copyWith(color: DevfestColors.grey30),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
