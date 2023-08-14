import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/icons.dart';
import 'package:devfest23/core/themes/colors.dart';
import 'package:devfest23/core/themes/theme_data.dart';
import 'package:devfest23/core/widgets/animated_indexed_stack.dart';
import 'package:devfest23/core/widgets/schedule_tab_bar.dart';
import 'package:devfest23/features/home/widgets/favourite_session_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/enums/devfest_day.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key, required this.initialDay});

  final DevfestDay initialDay;

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late DevfestDay day;

  @override
  void initState() {
    super.initState();

    day = widget.initialDay;
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, isScrolledUnder) {
        return [
          SliverAppBar(
            pinned: true,
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
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalMargin),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: Constants.verticalGutter),
                  RichText(
                    text: TextSpan(
                      text: 'Favourites',
                      style: DevFestTheme.of(context)
                          .textTheme
                          ?.title01
                          ?.copyWith(
                            color: DevFestTheme.of(context).onBackgroundColor,
                          ),
                      children: const [
                        WidgetSpan(child: SizedBox(width: 4)),
                        TextSpan(text: '❤️')
                      ],
                    ),
                  ),
                  const SizedBox(height: Constants.smallVerticalGutter),
                  Text(
                    'View all your saved sessions here',
                    style: DevFestTheme.of(context).textTheme?.body02?.copyWith(
                          color: MediaQuery.platformBrightnessOf(context) ==
                                  Brightness.dark
                              ? DevfestColors.grey80
                              : DevfestColors.grey40,
                        ),
                  ),
                  const SizedBox(height: Constants.verticalGutter * 2),
                ],
              ),
            ),
          ),
          SliverAppBar(
            pinned: true,
            backgroundColor: DevFestTheme.of(context).backgroundColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            toolbarHeight: 80,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalMargin),
              child: ScheduleTabBar(
                index: day.index,
                onTap: (tab) {
                  setState(() {
                    day = DevfestDay.values[tab];
                  });
                },
              ),
            ),
          ),
        ];
      },
      body: AnimatedIndexedStack(
        index: day.index,
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalMargin),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return FavouriteSessionTile(isActive: index == 1);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemCount: 5,
          ),
          ListView.separated(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalMargin),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return FavouriteSessionTile(isActive: index == 1);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}
