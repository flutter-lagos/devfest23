import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/images.dart';
import 'package:devfest23/core/themes/colors.dart';
import 'package:devfest23/core/themes/theme_data.dart';
import 'package:devfest23/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../core/providers/providers.dart';

@widgetbook.UseCase(
    name: 'Schedule tile',
    type: DevfestScheduleTiles,
    designLink:
        'https://www.figma.com/file/CCnX5Sh86ILqRn7ng6Shlr/DevFest-Jordan-Year---Mobile-App?node-id=1591%3A1213&mode=dev')
Widget devfestAgendaTile(BuildContext context) {
  return Material(
    color: DevFestTheme.of(context).backgroundColor,
    child: Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Constants.horizontalMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScheduleTile(onTap: () {}),
        ],
      ),
    ),
  );
}

class ScheduleTile extends StatelessWidget {
  const ScheduleTile({
    super.key,
    this.onTap,
    this.isGeneral = false,
  });

  // TODO: Handle case for ongoing

  final VoidCallback? onTap;
  final bool isGeneral;

  static final timeFormat = DateFormat('hh:mm');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: _InActiveFavouriteSessionTile(isGeneral: isGeneral),
    );
  }
}

class _InActiveFavouriteSessionTile extends ConsumerStatefulWidget {
  const _InActiveFavouriteSessionTile({Key? key, this.isGeneral = false})
      : super(key: key);

  final bool isGeneral;

  @override
  ConsumerState<_InActiveFavouriteSessionTile> createState() =>
      _InActiveFavouriteSessionTileState();
}

class _InActiveFavouriteSessionTileState
    extends ConsumerState<_InActiveFavouriteSessionTile> {
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: ShapeDecoration(
              color: DevFestTheme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFF4C4C4C)),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(Constants.verticalGutter),
            child: Column(
              children: [
                if (!widget.isGeneral) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MOBILE DEVELOPMENT',
                        style: DevFestTheme.of(context)
                            .textTheme
                            ?.body04
                            ?.copyWith(
                                color: isDark
                                    ? DevfestColors.grey70
                                    : DevfestColors.grey30),
                      ),
                      const _FavouriteIcon(),
                    ],
                  ),
                  const SizedBox(height: Constants.verticalGutter)
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
                            'Animations in Flutter and how to make them',
                            style: DevFestTheme.of(context)
                                .textTheme
                                ?.title02
                                ?.copyWith(
                                  color: isDark
                                      ? DevfestColors.grey100
                                      : DevfestColors.grey0,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                          ),
                          const SizedBox(height: Constants.verticalGutter),
                          Row(
                            children: [
                              Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    color: DevfestColors.green,
                                    width: 2,
                                  ),
                                  image: const DecorationImage(
                                    image:
                                        AssetImage(AppImages.devfestLogoLight),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(width: Constants.horizontalGutter),
                              Text.rich(
                                TextSpan(
                                  text: 'Samuel Abada',
                                  style: DevFestTheme.of(context)
                                      .textTheme
                                      ?.body03
                                      ?.copyWith(
                                        color: isDark
                                            ? DevfestColors.grey100
                                            : DevfestColors.grey10,
                                      ),
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Container(
                                        height: 8,
                                        width: 8,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal:
                                                Constants.horizontalGutter),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? DevfestColors.grey30
                                              : DevfestColors.grey70,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    const TextSpan(text: '10:00 AM'),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Container(
                                        height: 8,
                                        width: 8,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal:
                                                Constants.horizontalGutter),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? DevfestColors.grey30
                                              : DevfestColors.grey70,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    const TextSpan(text: 'Hall A'),
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
        )
      ],
    );
  }
}

class _FavouriteIcon extends StatelessWidget {
  const _FavouriteIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      alignment: Alignment.center,
      child: const Icon(
        Icons.star_border_rounded,
        color: DevfestColors.grey70,
      ),
    );
  }
}
