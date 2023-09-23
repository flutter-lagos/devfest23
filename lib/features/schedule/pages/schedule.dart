import 'package:devfest23/core/enums/devfest_day.dart';
import 'package:devfest23/core/router/navigator.dart';
import 'package:devfest23/core/router/routes.dart';
import 'package:devfest23/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants.dart';
import '../../../core/icons.dart';
import '../../../core/themes/themes.dart';
import '../../../core/widgets/schedule_tab_bar.dart';
import '../../home/widgets/header_delegate.dart';
import '../../home/widgets/schedule_tile.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key, required this.initialDay});

  final DevfestDay initialDay;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
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
                Constants.horizontalMargin.horizontalSpace,
                SvgPicture.asset(
                  AppIcons.devfestLogo,
                  height: 16.h,
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
            ).w,
            sliver: SliverToBoxAdapter(
              child: Text.rich(
                TextSpan(
                  text: '🕧',
                  style: DevFestTheme.of(context).textTheme?.title01,
                  children: [
                    WidgetSpan(child: 4.horizontalSpace),
                    const TextSpan(text: 'Schedule')
                  ],
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: HeaderDelegate(
              height: 100.w,
              child: Container(
                height: 100.w,
                color: DevFestTheme.of(context).backgroundColor,
                padding: const EdgeInsets.symmetric(
                        horizontal: Constants.horizontalMargin)
                    .w,
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
          ),
        ];
      },
      body: AnimatedIndexedStack(
        index: day.index,
        children: [
          ListView.separated(
            key: const PageStorageKey<String>('Day1'),
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.horizontalMargin,
            ).w,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ScheduleTile(
                isGeneral: index % 2 == 0,
                onTap: () {
                  context.go("${RoutePaths.session}/$index");
                },
              );
            },
            separatorBuilder: (_, __) => 14.verticalSpace,
            itemCount: 5,
          ),
          ListView.separated(
            key: const PageStorageKey<String>('Day2'),
            padding: const EdgeInsets.symmetric(
                    horizontal: Constants.horizontalMargin)
                .w,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ScheduleTile(
                onTap: () {
                  context.go("${RoutePaths.session}/$index");
                },
              );
            },
            separatorBuilder: (_, __) => 14.verticalSpace,
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}
