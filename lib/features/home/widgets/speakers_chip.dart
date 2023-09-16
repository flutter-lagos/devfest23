import 'package:devfest23/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../core/constants.dart';
import '../../../core/images.dart';
import '../../../core/providers/providers.dart';
import '../../../core/themes/themes.dart';

@widgetbook.UseCase(
    name: 'Speaker chip',
    type: DevfestChips,
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
          SpeakersChip(
            name: 'Daniele Buffa',
            shortInfo: 'CEO, Design Lead, O2 Labs',
            moodColor: Color(0xfff6eeee),
          ),
          SizedBox(height: 10),
          SpeakersChip(
            name: 'Samuel Abada',
            shortInfo: 'Senior Mobile Developer, Cruise Nation',
            moodColor: DevfestColors.greenSecondary,
          ),
          SizedBox(height: 10),
          SpeakersChip(
            name: 'Aisosa Idahor',
            shortInfo: 'Principal Designer, Meta',
            moodColor: DevfestColors.blueSecondary,
          ),
          SizedBox(height: 10),
          SpeakersChip(
            name: 'Juwon Olagoke',
            shortInfo: 'Senior Designer, Binance',
            moodColor: Color(0xffffafff),
          ),
        ],
      ),
    ),
  );
}

class SpeakersChip extends ConsumerWidget {
  const SpeakersChip({
    super.key,
    this.name = '',
    this.shortInfo = '',
    this.moodColor,
    this.onTap,
  });

  final String name;
  final String shortInfo;
  final Color? moodColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    final accentColor = moodColor ?? const Color(0xFFA8A3A3);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Constants.kAnimationDur,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          color: isDark ? accentColor : const Color(0xFF211212),
        ),
        padding: const EdgeInsets.only(top: 2, bottom: 4, left: 2, right: 4),
        child: AnimatedContainer(
          duration: Constants.kAnimationDur,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: isDark ? DevfestColors.grey10 : accentColor,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
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
                      name,
                      style:
                          DevFestTheme.of(context).textTheme?.title02?.copyWith(
                                color: isDark
                                    ? DevfestColors.grey100
                                    : DevfestColors.grey0,
                              ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      shortInfo,
                      style: DevFestTheme.of(context)
                          .textTheme
                          ?.body03
                          ?.copyWith(
                              color: isDark
                                  ? DevfestColors.grey80
                                  : DevfestColors.grey30),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
