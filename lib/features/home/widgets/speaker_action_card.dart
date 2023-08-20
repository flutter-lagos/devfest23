import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../core/providers/providers.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'Speaker action card',
    type: DevfestSpeakerActionCard,
    designLink:
        'https://www.figma.com/file/CCnX5Sh86ILqRn7ng6Shlr/DevFest-Jordan-Year---Mobile-App?node-id=1591%3A1213&mode=dev')
Widget devfestSpeakerActionCard(BuildContext context) {
  return Material(
    color: DevFestTheme.of(context).backgroundColor,
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.horizontalMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpeakerActionCard(),
        ],
      ),
    ),
  );
}

class SpeakerActionCard extends ConsumerWidget {
  const SpeakerActionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: DevFestTheme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: DevfestColors.grey90),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MOBILE DEVELOPMENT',
            style: DevFestTheme.of(context).textTheme?.body04?.copyWith(
                  color: isDark ? DevfestColors.grey70 : DevfestColors.grey30,
                ),
          ),
          const SizedBox(height: Constants.smallVerticalGutter),
          Text(
            'Animations in Flutter and how to make them',
            style: DevFestTheme.of(context).textTheme?.title02?.copyWith(
                  color: isDark ? DevfestColors.grey100 : DevfestColors.grey0,
                ),
          ),
          const SizedBox(height: Constants.smallVerticalGutter),
          Row(
            children: [
              Text(
                '11:00 AM',
                style: DevFestTheme.of(context).textTheme?.body03?.copyWith(
                      color:
                          isDark ? DevfestColors.grey100 : DevfestColors.grey10,
                    ),
              ),
              Container(
                height: 8,
                width: 8,
                margin: const EdgeInsets.symmetric(
                    horizontal: Constants.horizontalGutter),
                decoration: BoxDecoration(
                  color: isDark ? DevfestColors.grey30 : DevfestColors.grey70,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                'Hall A',
                style: DevFestTheme.of(context).textTheme?.body03?.copyWith(
                      color:
                          isDark ? DevfestColors.grey100 : DevfestColors.grey10,
                    ),
              ),
            ],
          ),
          const SizedBox(height: Constants.verticalGutter),
          DevfestFavouriteButton(
              onPressed: () {}, title: const Text('Add Talk to Favourites')),
        ],
      ),
    );
  }
}
