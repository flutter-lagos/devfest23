import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/icons.dart';
import '../../../core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../core/constants.dart';
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
          SizedBox(height: 10),
          SpeakerShimmerChip(
            moodColor: DevfestColors.blueSecondary,
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
    this.avatarImageUrl = '',
  });

  final String name;
  final String shortInfo;
  final Color? moodColor;
  final void Function()? onTap;
  final String avatarImageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    final accentColor = moodColor ?? const Color(0xfff6eeee);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Constants.kAnimationDur,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16).w,
        decoration: BoxDecoration(
          color: isDark ? DevfestColors.grey10 : accentColor,
          borderRadius: BorderRadius.circular(24),
          border: Border(
            left: BorderSide(
              width: 2,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: isDark ? accentColor : const Color(0xFF211212),
            ),
            top: BorderSide(
              width: 2,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: isDark ? accentColor : const Color(0xFF211212),
            ),
            right: BorderSide(
              width: 4,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: isDark ? accentColor : const Color(0xFF211212),
            ),
            bottom: BorderSide(
              width: 4,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: isDark ? accentColor : const Color(0xFF211212),
            ),
          ),
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: avatarImageUrl,
              imageBuilder: (context, imageProvider) => Container(
                height: 54.w,
                width: 54.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AppIcons.devfestLogo,
                  height: 16.h,
                  fit: BoxFit.contain,
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    shortInfo,
                    style: DevFestTheme.of(context).textTheme?.body03?.copyWith(
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
    );
  }
}

class SpeakerShimmerChip extends ConsumerWidget {
  const SpeakerShimmerChip({super.key, this.moodColor});

  final Color? moodColor;

  @override
  Widget build(BuildContext context, ref) {
    final isDark = ref.watch(isDarkProvider);
    final accentColor = moodColor ?? const Color(0xfff6eeee);
    return AnimatedContainer(
      duration: Constants.kAnimationDur,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16).w,
      decoration: BoxDecoration(
        color: isDark ? DevfestColors.grey10 : accentColor,
        borderRadius: BorderRadius.circular(24),
        border: Border(
          left: BorderSide(
            width: 2,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: isDark ? accentColor : const Color(0xFF211212),
          ),
          top: BorderSide(
            width: 2,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: isDark ? accentColor : const Color(0xFF211212),
          ),
          right: BorderSide(
            width: 4,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: isDark ? accentColor : const Color(0xFF211212),
          ),
          bottom: BorderSide(
            width: 4,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: isDark ? accentColor : const Color(0xFF211212),
          ),
        ),
      ),
      child: Shimmer.fromColors(
        baseColor: isDark ? DevfestColors.grey10 : accentColor,
        highlightColor: isDark ? accentColor : const Color(0xFF211212),
        period: Constants.kShimmerDur,
        child: Row(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: ShapeDecoration(
                color: isDark ? accentColor : const Color(0xFF211212),
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
                  Container(
                    height: 22,
                    width: double.infinity,
                    color: isDark ? accentColor : const Color(0xFF211212),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 16,
                    color: isDark ? accentColor : const Color(0xFF211212),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
