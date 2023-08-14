import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/images.dart';
import 'package:devfest23/core/themes/colors.dart';
import 'package:devfest23/core/themes/theme_data.dart';
import 'package:devfest23/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Favourite sessions tile',
    type: DevfestTiles,
    designLink:
        'https://www.figma.com/file/CCnX5Sh86ILqRn7ng6Shlr/DevFest-Jordan-Year---Mobile-App?node-id=1591%3A1213&mode=dev')
Widget devfestFavouriteSessionTile(BuildContext context) {
  return Material(
    color: DevFestTheme.of(context).backgroundColor,
    child: Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Constants.horizontalMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FavouriteSessionTile(
            onTap: () {},
          ),
          const SizedBox(height: Constants.verticalGutter),
          FavouriteSessionTile(
            onTap: () {},
            isActive: true,
          )
        ],
      ),
    ),
  );
}

class FavouriteSessionTile extends StatelessWidget {
  const FavouriteSessionTile({
    super.key,
    this.onTap,
    bool isActive = false,
  }) : _isActive = isActive;

  final VoidCallback? onTap;
  final bool _isActive;

  static final timeFormat = DateFormat('hh:mm');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: _isActive
          ? const _ActiveFavouriteSessionTile()
          : const _InActiveFavouriteSessionTile(),
    );
  }
}

class _ActiveFavouriteSessionTile extends StatelessWidget {
  const _ActiveFavouriteSessionTile();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          FavouriteSessionTile.timeFormat.format(DateTime.now()),
          style: DevFestTheme.of(context).textTheme?.body01,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: DevFestTheme.of(context).onBackgroundColor,
            ),
            padding:
                const EdgeInsets.only(top: 2, bottom: 4, left: 2, right: 4),
            child: Container(
              decoration: BoxDecoration(
                color: DevFestTheme.of(context).backgroundColor,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(14),
                  right: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.all(Constants.verticalGutter),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Animations in Flutter and how to make them',
                          style: DevFestTheme.of(context).textTheme?.body03,
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
                                  image: AssetImage(AppImages.devfestLogoLight),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(width: Constants.horizontalGutter),
                            RichText(
                              text: TextSpan(
                                text: 'Samuel Abada',
                                style: DevFestTheme.of(context)
                                    .textTheme
                                    ?.body04
                                    ?.copyWith(
                                        color: DevFestTheme.of(context)
                                            .onBackgroundColor),
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
                                        color: DevFestTheme.of(context)
                                            .onBackgroundColor,
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
                  const SizedBox(width: Constants.horizontalGutter),
                  const _FavouriteIcon()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _InActiveFavouriteSessionTile extends StatelessWidget {
  const _InActiveFavouriteSessionTile();

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          FavouriteSessionTile.timeFormat.format(DateTime.now()),
          style: DevFestTheme.of(context).textTheme?.body01?.copyWith(
                color: isDark ? DevfestColors.grey30 : DevfestColors.grey70,
              ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              border: Border.all(
                color: isDark ? DevfestColors.grey10 : DevfestColors.grey90,
              ),
            ),
            padding: const EdgeInsets.all(Constants.verticalGutter),
            child: Row(
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
                            ?.body03
                            ?.copyWith(
                              color: DevFestTheme.of(context)
                                  .inverseBackgroundColor,
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
                                image: AssetImage(AppImages.devfestLogoLight),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(width: Constants.horizontalGutter),
                          RichText(
                            text: TextSpan(
                              text: 'Samuel Abada',
                              style: DevFestTheme.of(context)
                                  .textTheme
                                  ?.body04
                                  ?.copyWith(
                                    color: DevFestTheme.of(context)
                                        .inverseBackgroundColor,
                                  ),
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Container(
                                    height: 8,
                                    width: 8,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: Constants.horizontalGutter),
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
                const SizedBox(width: Constants.horizontalGutter),
                const _FavouriteIcon()
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: DevfestColors.blueSecondary.withOpacity(0.4),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.star_border_rounded,
        color: DevfestColors.blue,
      ),
    );
  }
}
