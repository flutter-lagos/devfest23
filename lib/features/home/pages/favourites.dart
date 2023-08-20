import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/icons.dart';
import 'package:devfest23/core/themes/theme_data.dart';
import 'package:devfest23/core/widgets/animated_indexed_stack.dart';
import 'package:devfest23/core/widgets/schedule_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/enums/devfest_day.dart';
import '../widgets/schedule_tile.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key, required this.initialDay});

  final DevfestDay initialDay;

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late DevfestDay day;
  late ScrollController _scrollController;
  Map<int, double> scrollOffsets = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        scrollOffsets[day.index] = _scrollController.offset;
      });

    day = widget.initialDay;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      key: const PageStorageKey<String>('FavouritesPageScrollView'),
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
            padding: const EdgeInsets.only(
              left: Constants.horizontalMargin,
              right: Constants.horizontalMargin,
              bottom: Constants.largeVerticalGutter,
            ),
            sliver: SliverToBoxAdapter(
              child: Text.rich(
                TextSpan(
                  text: '🌟',
                  style: DevFestTheme.of(context)
                      .textTheme
                      ?.title01
                      ?.copyWith(fontWeight: FontWeight.w500),
                  children: const [
                    WidgetSpan(child: SizedBox(width: 4)),
                    TextSpan(text: 'Favourites')
                  ],
                ),
              ),
            ),
          ),
          SliverAppBar(
            pinned: true,
            backgroundColor: DevFestTheme.of(context).backgroundColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalMargin),
              child: ScheduleTabBar(
                index: day.index,
                onTap: (tab) {
                  setState(() {
                    day = DevfestDay.values[tab];
                    if (scrollOffsets.containsKey(day.index)) {
                      _scrollController.jumpTo(scrollOffsets[day.index]!);
                    } else {
                      _scrollController.jumpTo(0);
                    }
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
            key: const PageStorageKey<String>('Day1'),
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalMargin),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const ScheduleTile();
            },
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemCount: 5,
          ),
          ListView.separated(
            key: const PageStorageKey<String>('Day2'),
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalMargin),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const ScheduleTile();
            },
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}
