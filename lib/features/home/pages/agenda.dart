import 'package:devfest23/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/enums/devfest_day.dart';
import '../../../core/enums/tab_item.dart';
import '../../../core/icons.dart';
import '../../../core/images.dart';
import '../../../core/providers/providers.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/schedule_tab_bar.dart';
import '../widgets/schedule_tile.dart';
import '../widgets/speakers_chip.dart';
import '../widgets/sponsors_chip.dart';

class AgendaPage extends ConsumerStatefulWidget {
  const AgendaPage({super.key, required this.initialDay});

  final DevfestDay initialDay;

  @override
  ConsumerState<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends ConsumerState<AgendaPage> {
  late DevfestDay day;

  @override
  void initState() {
    super.initState();

    day = widget.initialDay;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkProvider);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, isScrolledUnder) {
          return [
            SliverAppBar(
              backgroundColor: DevFestTheme.of(context).backgroundColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              leadingWidth: 100,
              leading: Row(
                children: [
                  const SizedBox(width: Constants.horizontalMargin),
                  SvgPicture.asset(
                    AppIcons.devfestLogo,
                    height: 16,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                left: Constants.horizontalMargin,
                right: Constants.horizontalMargin,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Hey Bruce',
                        style: DevFestTheme.of(context).textTheme?.title01,
                        children: const [
                          WidgetSpan(child: SizedBox(width: 4)),
                          TextSpan(text: '🤭')
                        ],
                      ),
                    ),
                    const SizedBox(height: Constants.smallVerticalGutter),
                    Text(
                      'Welcome to Devfest Lagos 2023 🥳',
                      style:
                          DevFestTheme.of(context).textTheme?.body02?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? DevfestColors.grey80
                                    : DevfestColors.grey40,
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Constants.verticalGutter),
                Text(
                  'SCHEDULE',
                  style: DevFestTheme.of(context).textTheme?.body04?.copyWith(
                        color: DevfestColors.grey30,
                      ),
                ),
                const SizedBox(height: Constants.verticalGutter),
                ScheduleTabBar(
                  index: day.index,
                  onTap: (tab) {
                    setState(() {
                      day = DevfestDay.values.elementAt(tab);
                    });
                  },
                ),
                [
                  AnimatedScale(
                    key: const Key('AnimatedScaleDay1'),
                    scale: day.index == 0 ? 1.0 : 0.98,
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 250),
                    child: AnimatedOpacity(
                      key: const Key('AnimatedOpacityDay1'),
                      opacity: day.index == 0 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.decelerate,
                      child: ListView.separated(
                        shrinkWrap: true,
                        key: const PageStorageKey<String>('Day1'),
                        padding: const EdgeInsets.only(
                            top: Constants.verticalGutter),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ScheduleTile(isGeneral: index == 0);
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemCount: 4,
                      ),
                    ),
                  ),
                  AnimatedScale(
                    key: const Key('AnimatedScaleDay2'),
                    scale: day.index == 1 ? 1.0 : 0.98,
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 100),
                    child: AnimatedOpacity(
                      key: const Key('AnimatedOpacityDay2'),
                      opacity: day.index == 1 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.decelerate,
                      child: ListView.separated(
                        shrinkWrap: true,
                        key: const PageStorageKey<String>('Day2'),
                        padding: const EdgeInsets.only(
                            top: Constants.verticalGutter),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ScheduleTile(isGeneral: index == 0);
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemCount: 4,
                      ),
                    ),
                  ),
                ].elementAt(day.index),
                Center(
                  child: TextButton.icon(
                    onPressed: () {},
                    label: const Icon(
                      Icons.arrow_forward,
                      color: DevfestColors.blue,
                    ),
                    icon: const Text(
                      'View Full Agenda',
                      style: TextStyle(color: DevfestColors.blue),
                    ),
                  ),
                ),
                Text(
                  'SPONSORS',
                  style: DevFestTheme.of(context).textTheme?.body04,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      ...[
                        AppImages.googleLogo,
                        AppImages.spotifyLogo,
                        AppImages.uberLogo,
                        AppImages.lyftLogo
                      ]
                          .map(
                            (sponsorImage) => SponsorsChip(image: sponsorImage),
                          )
                          .toList()
                    ],
                  ),
                ),
                Center(
                  child: TextButton.icon(
                    onPressed: () {},
                    label: const Icon(
                      Icons.arrow_forward,
                      color: DevfestColors.blue,
                    ),
                    icon: const Text(
                      'View All Sponsors',
                      style: TextStyle(color: DevfestColors.blue),
                    ),
                  ),
                ),
                Text(
                  'SPEAKERS',
                  style: DevFestTheme.of(context).textTheme?.body04,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 16),
                  itemBuilder: (context, index) {
                    return SpeakersChip(
                      name: 'Samuel Abada',
                      shortInfo: 'Senior Mobile Engineer, Cruise Nation',
                      onTap: () {
                        
                        context.push(
                            '/app/${TabItem.speakers.name}/${DevfestDay.day1.name}');
                        context.pushReplacement(
                            '/speakers/${TabItem.speakers.name}/$index');
                      },
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: Constants.verticalGutter),
                  itemCount: 4,
                ),
                Center(
                  child: TextButton.icon(
                    onPressed: () {},
                    label: const Icon(
                      Icons.arrow_forward,
                      color: DevfestColors.blue,
                    ),
                    icon: const Text(
                      'View All Speakers',
                      style: TextStyle(color: DevfestColors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
