import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/theme_data.dart';
import '../../../core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../core/providers/providers.dart';

@widgetbook.UseCase(
    name: 'Schedule tile',
    type: DevfestTiles,
    designLink:
        'https://www.figma.com/file/CCnX5Sh86ILqRn7ng6Shlr/DevFest-Jordan-Year---Mobile-App?node-id=1591%3A1213&mode=dev')
Widget devfestScheduleTile(BuildContext context) {
  return Material(
    color: DevFestTheme.of(context).backgroundColor,
    child: Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Constants.horizontalMargin),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScheduleTile(
              onTap: () {},
              isGeneral: true,
              title: 'Animations in Flutter and how to make them',
              speaker: 'Samuel Abada',
              time: '10:00 AM',
              venue: 'Hall A',
              category: 'MOBILE DEVELOPMENT',
            ),
            const SizedBox(height: 8),
            ScheduleTile(
              onTap: () {},
              title: 'Animations in Flutter and how to make them',
              speaker: 'Samuel Abada',
              time: '10:00 AM',
              venue: 'Hall A',
              category: 'MOBILE DEVELOPMENT',
            ),
            const SizedBox(height: Constants.verticalGutter),
            ScheduleTile(
              onTap: () {},
              isGeneral: true,
              isOngoing: true,
              title: 'Animations in Flutter and how to make them',
              speaker: 'Samuel Abada',
              time: '10:00 AM',
              venue: 'Hall A',
              category: 'MOBILE DEVELOPMENT',
            ),
            const SizedBox(height: 8),
            ScheduleTile(
              onTap: () {},
              isOngoing: true,
              title: 'Animations in Flutter and how to make them',
              speaker: 'Samuel Abada',
              time: '10:00 AM',
              venue: 'Hall A',
              category: 'MOBILE DEVELOPMENT',
            ),
            const SizedBox(height: 8),
            const ScheduleTileShimmer(),
          ],
        ),
      ),
    ),
  );
}

class ScheduleTile extends StatelessWidget {
  const ScheduleTile({
    super.key,
    this.onTap,
    this.isGeneral = false,
    this.isOngoing = false,
    this.title = '',
    this.speaker = '',
    this.time = '',
    this.venue = '',
    this.category = '',
    this.speakerImage = '',
    this.hasRsvped = false,
  });

  final VoidCallback? onTap;
  final bool isGeneral;
  final bool isOngoing;
  final String title;
  final String speaker;
  final String time;
  final String venue;
  final String category;
  final String speakerImage;
  final bool hasRsvped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: _InActiveFavouriteSessionTile(
        isGeneral: isGeneral,
        isOngoing: isOngoing,
        title: title,
        speaker: speaker,
        time: time,
        venue: venue,
        category: category,
        speakerImage: speakerImage,
        hasRsvped: hasRsvped,
      ),
    );
  }
}

class _InActiveFavouriteSessionTile extends ConsumerStatefulWidget {
  const _InActiveFavouriteSessionTile({
    required this.isGeneral,
    required this.isOngoing,
    required this.title,
    required this.speaker,
    required this.time,
    required this.venue,
    required this.category,
    required this.speakerImage,
    required this.hasRsvped,
  });

  final bool isGeneral;
  final bool isOngoing;
  final String title;
  final String speaker;
  final String time;
  final String venue;
  final String category;
  final String speakerImage;
  final bool hasRsvped;

  @override
  ConsumerState<_InActiveFavouriteSessionTile> createState() =>
      _InActiveFavouriteSessionTileState();
}

class _InActiveFavouriteSessionTileState
    extends ConsumerState<_InActiveFavouriteSessionTile> {
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkProvider);
    return Container(
      decoration: ShapeDecoration(
        color: DevFestTheme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: isDark ? DevfestColors.grey10 : const Color(0xFF4C4C4C)),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(Constants.verticalGutter).w,
      child: Column(
        children: [
          if (!widget.isGeneral || widget.isOngoing) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.isOngoing) ...[
                      const _OngoingIndicator(),
                      Constants.horizontalGutter.horizontalSpace,
                    ],
                    if (!widget.isGeneral) ...[
                      Text(
                        widget.category,
                        style: DevFestTheme.of(context)
                            .textTheme
                            ?.body04
                            ?.copyWith(
                              color: isDark
                                  ? DevfestColors.grey80
                                  : DevfestColors.grey30,
                            ),
                      ),
                    ]
                  ],
                ),
                if (!widget.isGeneral)
                  _FavouriteIcon(
                    isFavourite: widget.hasRsvped,
                  ),
              ],
            ),
            widget.isGeneral
                ? Constants.smallVerticalGutter.verticalSpace
                : Constants.verticalGutter.verticalSpace,
          ],
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.title,
                      style:
                          DevFestTheme.of(context).textTheme?.title02?.copyWith(
                                color: isDark
                                    ? DevfestColors.grey100
                                    : DevfestColors.grey0,
                              ),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                    Constants.verticalGutter.verticalSpace,
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.speakerImage,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageBuilder: (context, imageProvider) => Container(
                            height: 32.w,
                            width: 32.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: DevfestColors.green,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Constants.horizontalGutter),
                        Text.rich(
                          TextSpan(
                            text: widget.speaker,
                            style: DevFestTheme.of(context)
                                .textTheme
                                ?.body03
                                ?.copyWith(
                                  color: isDark
                                      ? DevfestColors.grey80
                                      : DevfestColors.grey10,
                                ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: AnimatedContainer(
                                  duration: Constants.kAnimationDur,
                                  height: 8.w,
                                  width: 8.w,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: Constants.horizontalGutter),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? DevfestColors.grey100
                                        : DevfestColors.grey70,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              TextSpan(text: widget.time),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: AnimatedContainer(
                                  duration: Constants.kAnimationDur,
                                  height: 8.w,
                                  width: 8.w,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: Constants.horizontalGutter),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? DevfestColors.grey100
                                        : DevfestColors.grey70,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              TextSpan(text: widget.venue),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OngoingIndicator extends StatelessWidget {
  const _OngoingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.all(Radius.circular(Constants.horizontalGutter)),
        color: const Color(0xff81c995).withOpacity(0.2),
      ),
      child: Container(
        height: 8,
        width: 8,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff24753a),
        ),
      ),
    );
  }
}

class _FavouriteIcon extends ConsumerWidget {
  const _FavouriteIcon({this.isFavourite = false});

  final bool isFavourite;

  @override
  Widget build(BuildContext context, ref) {
    return AnimatedContainer(
      duration: Constants.kAnimationDur,
      height: 30,
      width: 30,
      alignment: Alignment.center,
      child: isFavourite
          ? const Icon(
              Symbols.grade_rounded,
              key: Key('rsvp-icon'),
              weight: Constants.iconWeight,
              color: DevfestColors.yellow,
              fill: 1,
            )
          : Icon(
              Icons.star_border_rounded,
              key: const Key('un-rsvp-icon'),
              color: ref.watch(isDarkProvider)
                  ? DevfestColors.grey90
                  : DevfestColors.grey70,
            ),
    );
  }
}

class ScheduleTileShimmer extends ConsumerWidget {
  const ScheduleTileShimmer({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isDark = ref.watch(isDarkProvider);
    return Container(
      decoration: ShapeDecoration(
        color: DevFestTheme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: isDark ? DevfestColors.grey10 : const Color(0xFF4C4C4C)),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(Constants.verticalGutter).w,
      child: Shimmer.fromColors(
        baseColor: isDark ? DevfestColors.grey90 : DevfestColors.grey30,
        highlightColor: isDark ? DevfestColors.grey100 : DevfestColors.grey20,
        period: Constants.kShimmerDur,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 32,
                        color: isDark
                            ? DevfestColors.grey80
                            : DevfestColors.grey10,
                      ),
                      Constants.verticalGutter.verticalSpace,
                      Row(
                        children: [
                          Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark
                                  ? DevfestColors.grey80
                                  : DevfestColors.grey10,
                              border: Border.all(
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: DevfestColors.green,
                                width: 2,
                              ),
                            ),
                          ),
                          const SizedBox(width: Constants.horizontalGutter),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 16,
                                    color: isDark
                                        ? DevfestColors.grey80
                                        : DevfestColors.grey10,
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Constants.kAnimationDur,
                                  height: 8.w,
                                  width: 8.w,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: Constants.horizontalGutter),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? DevfestColors.grey100
                                        : DevfestColors.grey70,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 16,
                                    color: isDark
                                        ? DevfestColors.grey80
                                        : DevfestColors.grey10,
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Constants.kAnimationDur,
                                  height: 8.w,
                                  width: 8.w,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: Constants.horizontalGutter),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? DevfestColors.grey100
                                        : DevfestColors.grey70,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 16,
                                    color: isDark
                                        ? DevfestColors.grey80
                                        : DevfestColors.grey10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
